Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7694CC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585040794;
	bh=MbR2LC2Cjq+KKlYVGw23IZaJEiAW55glNu/IL1UtcMM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TQZm/xbzGhicGnVEDTAW2ARF1v8qX8IG2w+wkmwQI8KojWW3yqcpFMc78dDa5ayXu
	 HLROZjiORA5oev6oYYSeO4X8XbGu8BE+JYmDGU2vLdr+fLYpa7ioqdb/buuP6gsF7I
	 lmW7RZT3NwOdMFH3CGQY1trL8U7+7IQw0vThm0rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCXJGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:06:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50530 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCXJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:06:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id d198so2315323wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J/FvSiiKqz6Wrld0ZpjDn6jlfslfOdvkSKPWQpTVzPE=;
        b=TR919/onONIFWdcAm0zDJPM+4QNfayctZ2NyKgs0KriTH+CqaIfg/uevBgdfodXk2U
         cogChjEZCy2mKWKyTquMz9wAHQzeYjuqU4BspT7ViHE6ysFtgSZqVPPiW9yiiMa0UW9/
         l6sDrEACf59oHtPdR1jegaBq76lmBWsruL1sRoIot+6E8CKILye2T0gQrEzmkbdW1SjU
         NWW7Nc6f4wWnzUH31XKDWCWh0l+OuX/YIBArmvqD/wvHsZBf8OhTQwZW56BgmFyIfSce
         HvDLQmHwz0t9ydwe9ORoDduL+GWoKRPMG+VJ2KpqWu1fi/OPogSOGFPSMa6k6Q6YN0Yz
         0tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=J/FvSiiKqz6Wrld0ZpjDn6jlfslfOdvkSKPWQpTVzPE=;
        b=ZKBKnqcVWyYBVhAARIxXjYJY5GEsKSfQxCwXEweKQ9BHc43wPsWVxQVb+/UtYdxFjS
         D58KM12NmHVJ6BKF7tgbQoojUpZmrMZPwuw8LvA3XvcuBe2w68wUlSLd/S18QGxf1S2q
         HmLEEBpVnF5StNZyxA7BtWooD7tU5qDfyTK6hvdY94qpZTP4Bw9UCDNn/vXSjuyJD/zI
         si1EnpS5SUyEroP8QgXtCeipx1yXjmRkUDPCXHqI8JWOubo6waUhfSwYPdplGF3QhmTa
         Z3Uw7DglZXVWhojaAjFD3hVcR++3oNaQO3IzX4kB75NVEdmAw/xqxlyLuhoJA03zONjx
         KKvA==
X-Gm-Message-State: ANhLgQ0yE26Ymt52FTPN8ltu9W7NZ5NeRzJJ6Qxsg5JslpFXsTTJrAjN
        T6sJa0uej/gJPEeENnUKeXjkl+DC
X-Google-Smtp-Source: ADFU+vt8EQLZ1USb9dKKSNQfu8ywnXjS88qFoKviiElMF8tFDUqsj96tZBox4D8XCnjuaZwSaVqFlg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr1520015wmk.39.1585040790437;
        Tue, 24 Mar 2020 02:06:30 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w81sm3478926wmg.19.2020.03.24.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 02:06:29 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:06:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86 fix
Message-ID: <20200324090627.GA46739@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 870b4333a62e45b0b2000d14b301b7b8b8cad9da x86/ioremap: Fix CONFIG_EFI=n build

A build fix with certain Kconfig combinations.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/ioremap: Fix CONFIG_EFI=n build


 arch/x86/mm/ioremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 935a91e1fd77..18c637c0dc6f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -115,6 +115,9 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
 	if (!sev_active())
 		return;
 
+	if (!IS_ENABLED(CONFIG_EFI))
+		return;
+
 	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
 		desc->flags |= IORES_MAP_ENCRYPTED;
 }
