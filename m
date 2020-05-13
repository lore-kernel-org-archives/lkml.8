Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA17C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224F9205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363806;
	bh=2vyF+S/PDQhriF+Z8BMNLoo5/iIbcU3qwbW9jy4iwZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=06FDgQECu5K7utOZ39BtO3w2kpi/WmPgUCvgKt3nslGMVPnnMLj/83qeBPjYbCYRU
	 rg/jtpBxoF5sZi5Of0lGEcNYGxHmIZx4gZdEQWwyYZSas0+hrNPBm7FrOoAxnK/8qe
	 b36D6kG+Lp7y4OISORZgGydcHUNef5cv9gcWCVEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbgEMJ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388403AbgEMJ4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85AEE20769;
        Wed, 13 May 2020 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363778;
        bh=2vyF+S/PDQhriF+Z8BMNLoo5/iIbcU3qwbW9jy4iwZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yj1wdINRu4NU202io9Nv0bRDKGBZF5EZMQ5d0/BartF3W+XeKz4f1tbBS4Z47o085
         a8RT9iKa2D86KlWSBb3fbQInJ4mRQr8/ffYD9xhNmwezT+qP6hjQvYVUPUnWwRic3j
         BPjJxumqlv0VD8iVYyHxKpugRvLvVw/baBed3Zyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Delalande <colona@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.6 112/118] scripts/decodecode: fix trapping instruction formatting
Date:   Wed, 13 May 2020 11:45:31 +0200
Message-Id: <20200513094427.823627648@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Delalande <colona@arista.com>

commit e08df079b23e2e982df15aa340bfbaf50f297504 upstream.

If the trapping instruction contains a ':', for a memory access through
segment registers for example, the sed substitution will insert the '*'
marker in the middle of the instruction instead of the line address:

	2b:   65 48 0f c7 0f          cmpxchg16b %gs:*(%rdi)          <-- trapping instruction

I started to think I had forgotten some quirk of the assembly syntax
before noticing that it was actually coming from the script.  Fix it to
add the address marker at the right place for these instructions:

	28:   49 8b 06                mov    (%r14),%rax
	2b:*  65 48 0f c7 0f          cmpxchg16b %gs:(%rdi)           <-- trapping instruction
	30:   0f 94 c0                sete   %al

Fixes: 18ff44b189e2 ("scripts/decodecode: make faulting insn ptr more robust")
Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/20200419223653.GA31248@visor
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/decodecode |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -126,7 +126,7 @@ faultlinenum=$(( $(wc -l $T.oo  | cut -d
 faultline=`cat $T.dis | head -1 | cut -d":" -f2-`
 faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
 
-cat $T.oo | sed -e "${faultlinenum}s/^\(.*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
+cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
 echo
 cat $T.aa
 cleanup


