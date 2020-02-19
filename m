Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F63DC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094252064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViOakdGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBSSxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:53:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44311 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSSxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:53:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so1761774wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0jHnaffbcHD6V2M8ivO3RIVjLtE2oGj6ul7Y+V3xbQI=;
        b=ViOakdGvUhPlGKtwy8mKWNhh+gKA3rYLyxWeWxf7uFUFeZi9MB+oo3FRB6jMwXyrXA
         n+UeTuNQLw4u8aKZjWmNwUbQlPzVcEAgVKH3B0n4UJzDVs20LudfO0pWtYPGqlh5mfka
         QShb8o88isr/9E37rgfAgsplzByFeOx1O/sxgVs+AvjzIN3zw4Qd61tiiWPCDpqc0xva
         qS6f5CR2dhfoHUzfys6iNQZVD14kQRiljV4N1lz3gZu8GcGxQLiORlxf6ReZvwZwO5Sn
         KlFlRhO0BYDdIYoysGC3J9493n3cEl7RPJ/RZS6dkz3dWNDW7ZIl+B/9Ws1+Wj9vqyEP
         qBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jHnaffbcHD6V2M8ivO3RIVjLtE2oGj6ul7Y+V3xbQI=;
        b=kHgcA0zfJNM61pNpaGLjH9hdzrP7SMBlstmOhWdTBqb9x6cc78ZIUsx6QOts0X190v
         ijoDPcOKtwT9NzVSPG+DFPfnoNb+a7yieNjz+cT6CuTSdK1tJesvRBcM8xPvltjK0c41
         nDcYcE1/fbmi6ql+iDV32WwPLobWIwdwn/ytIE5t9rwqeg2L6dtuTJ2TV/b4QYveT0es
         8bkz9/6qRMvYCK/Y2Yt+Rv67g54cdhwtsjkGzaFsXmEcq2j6+8BmGjLz2ST6CQt9WuGh
         JLMAWjxdI156YJgQfZMOEGrttff8Dg5YGEXcQrPR8c9DNTiuW21Zsn0fSdjx2oAn5+bG
         K9sQ==
X-Gm-Message-State: APjAAAUIvhDuwC+/o21uaR5oEptxGk5KebeRfdwbaoe9rAve6t9BPG3z
        FMjX61z4uG9KkEat57HhX7URxa8=
X-Google-Smtp-Source: APXvYqwt8psEXmllFUlT8Eg4aW4S22gxiQ93lZK+0iYUjyO6r260E2442ov6TIFW6bv6Lv6dn6ihwQ==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr37382645wrq.412.1582138412305;
        Wed, 19 Feb 2020 10:53:32 -0800 (PST)
Received: from avx2 ([46.53.251.159])
        by smtp.gmail.com with ESMTPSA id a16sm848167wrt.30.2020.02.19.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:53:31 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:53:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ELF: don't free interpreter's ELF pheaders on common path
Message-ID: <20200219185330.GA4933@avx2>
References: <20200219184847.GA4871@avx2>
 <20200219185012.GB4871@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219185012.GB4871@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static executables don't need to free NULL pointer.

It doesn't matter really because static executable is not common
scenario but do it anyway out of pedantry.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1075,6 +1075,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
+		kfree(interp_elf_phdata);
 	} else {
 		elf_entry = e_entry;
 		if (BAD_ADDR(elf_entry)) {
@@ -1083,7 +1084,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	kfree(interp_elf_phdata);
 	kfree(elf_phdata);
 
 	set_binfmt(&elf_format);
