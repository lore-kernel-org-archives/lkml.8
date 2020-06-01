Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A0FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B062074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="l8uyyoK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgFALlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:41:03 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:50976 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFALlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a/spLsCiFDfU8EwYTvsOCLW+Xq83nQJNL4ueRZd7Xao=; b=l8uyyoK+uw02KhozaPLGkqyXMf
        9fvB79hLN754jK4Qw9H/W39bAh56Wh1KZ23icRx//iaK84C8yR8rSNYj+Z1TxrCRFQ8o6ib3o4MtC
        6DPTJbkUMu3GCFFLE0pamH34H30wxXdo4fgMvxHb9LacEj4tGCz31YPMx6ZsC5O5uj9Q=;
Received: from lfbn-mar-1-909-138.w90-73.abo.wanadoo.fr ([90.73.224.138] helo=xps9380.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <rbernon@codeweavers.com>)
        id 1jfiWr-0004nS-5a; Mon, 01 Jun 2020 06:22:54 -0500
From:   =?UTF-8?q?R=C3=A9mi=20Bernon?= <rbernon@codeweavers.com>
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?q?R=C3=A9mi=20Bernon?= <rbernon@codeweavers.com>
Subject: [RFC PATCH 0/2] Add basic support for PE binary format
Date:   Mon,  1 Jun 2020 13:19:13 +0200
Message-Id: <20200601111915.114974-1-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying to improve compatibility between Wine and perf, and
I would like to have you opinion on this approach.

The main problem is that Wine uses PE binary format for most of its code
(and of course the Windows application it runs are also using PE binary
format), and perf is currently unable to parse them to get the symbol
table or even to find the debug file location from build_id or
.gnu_debuglink section.

I know that there's the possibility to use a perfmap file to map address
ranges to symbols, but it requires the runtime to generate it. And in
this case the information is already there in the PE files, just not in
a format that perf supports.

I also have some alternate ways to make it work, using perf-specific
tweaks in Wine for instance. But I believe that having better support of
PE binary format in perf could be generally useful, although for now
Wine is the only use-case I know.

This first starts using libbfd to parse the build_id and .gnu_debuglink
section, to make sure perf gets the debug file location even if the code
modules are in PE binary format.

Then, as Wine also generates debug files in PE or PDB format by default,
it also tries to use libbfd to parse the symbol table from the debug
file if libelf failed.

Of course, advanced features will still lack, but this makes it possible
to have perf report symbols and source-level annotations for any Windows
code running in Wine, assuming the modules aren't stripped.

Cheers,

Rémi Bernon (2):
  perf dso: Use libbfd to read build_id and .gnu_debuglink section
  perf symbols: Try reading the symbol table with libbfd

 tools/perf/util/symbol-elf.c |  65 +++++++++++++++++-
 tools/perf/util/symbol.c     | 124 +++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 3 deletions(-)

-- 
2.26.1

