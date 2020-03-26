Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03865C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB887206F8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgCZOHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:07:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgCZOHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:07:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03954B147;
        Thu, 26 Mar 2020 14:07:17 +0000 (UTC)
Date:   Thu, 26 Mar 2020 15:07:16 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     jiaxun.yang@flygoat.com, chenhc@lemote.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        lixuefeng@loongson.cn, paulburton@kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH v3 1/2] firmware: dmi: Add macro
 SMBIOS_ENTRY_POINT_SCAN_START
Message-ID: <20200326150716.47b4152f@endymion>
In-Reply-To: <8ee01022-d3d1-8145-1a0b-ba77c5bb7101@loongson.cn>
References: <1580875713-18252-1-git-send-email-yangtiezhu@loongson.cn>
        <8ee01022-d3d1-8145-1a0b-ba77c5bb7101@loongson.cn>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

On Thu, 20 Feb 2020 10:43:56 +0800, Tiezhu Yang wrote:
> Since this patch is independent and it has no any negative influence,
> could you apply it to your DMI tree first?

I've just queued your patch for kernel 5.6. Thanks for your
contribution and sorry for the delay.

-- 
Jean Delvare
SUSE L3 Support
