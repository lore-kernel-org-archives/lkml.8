Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1053EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2128E21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TS6+vUpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTJAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgDTJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:00:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C1C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:00:02 -0700 (PDT)
Received: from zn.tnic (p200300EC2F08140068F64889F873250A.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:1400:68f6:4889:f873:250a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AF8B1EC0B89;
        Mon, 20 Apr 2020 10:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587373199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W2mTIyJUw7Y0SoGo+I0s2YoZhJIU3pXAZRfpCIi4k28=;
        b=TS6+vUpmLe929HgbEL/OZ9PPl3bLHE8b1ODMqFhivxdu4d0GLLL7XMd7nxEOkbIEdGK/sZ
        6vhTXknLydiaw9DL5H6ybxFCZ3J5Nkkkf/486PR7Hpb48goVx8jbACsyVnStTPmg3Jjnqa
        rpXvjyDU8NPEtaYgLFTUzGO2E1OaMh4=
Date:   Mon, 20 Apr 2020 10:59:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ivan Delalande <colona@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/decodecode: fix trapping instruction formatting
Message-ID: <20200420085955.GA3147@zn.tnic>
References: <20200419223653.GA31248@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200419223653.GA31248@visor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 03:36:53PM -0700, Ivan Delalande wrote:
> If the trapping instruction contains a ':', for a memory access through
> segment registers for example, the sed substitution will insert the '*'
> marker in the middle of the instruction instead of the line address:
> 
> 	2b:   65 48 0f c7 0f          cmpxchg16b %gs:*(%rdi)          <-- trapping instruction
> 
> I started to think I had forgotten some quirk of the assembly syntax
> before noticing that it was actually coming from the script. Fix it to
> add the address marker at the right place for these instructions:
> 
> 	28:   49 8b 06                mov    (%r14),%rax
> 	2b:*  65 48 0f c7 0f          cmpxchg16b %gs:(%rdi)           <-- trapping instruction
> 	30:   0f 94 c0                sete   %al
> 
> Fixes: 18ff44b189e2 ("scripts/decodecode: make faulting insn ptr more robust")
> Signed-off-by: Ivan Delalande <colona@arista.com>
> ---
>  scripts/decodecode | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decodecode b/scripts/decodecode
> index ba8b8d5834e6..fbdb325cdf4f 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -126,7 +126,7 @@ faultlinenum=$(( $(wc -l $T.oo  | cut -d" " -f1) - \
>  faultline=`cat $T.dis | head -1 | cut -d":" -f2-`
>  faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
>  
> -cat $T.oo | sed -e "${faultlinenum}s/^\(.*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
> +cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
>  echo
>  cat $T.aa
>  cleanup
> -- 

Nice catch, thanks.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
