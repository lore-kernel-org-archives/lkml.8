Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A6C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E9820737
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt9CEVTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDDIx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:53:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33337 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgDDIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:53:25 -0400
Received: by mail-wr1-f49.google.com with SMTP id a25so11351635wrd.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=qGdwKA9rmdIyqGKO0IjJWKsmKZR9VJYYBo9155sisOo=;
        b=Dt9CEVTdqEmMLAO1mtlk74STBgT6iGX9OjtHBujDJ+Jgci0EanrXBeHNLpdjlzsvV/
         srUe2OIiA16QcFcPrdmX+SLBIEmfJcr9gYfwkqciAmG2Xx9oAtopNzbup0M2Ut4GJ1Hn
         QrrPGdpp4gLByLRZSARQyq3xBBgK/wNPM1sZqbMZ0hYGrJ/oYevZZFHezef0GFCg0Y96
         IFSpWCiP1FJSJKJe0d9AtE3qEeejI99oIWDe/z8cHSuUz+jAOpet+0pByI32L8ChzGSf
         d4sZH7vRd3aRDXKy0PPC1CgCaUVivQc3O7960iZ1WWnkvmNPEBgVbubhba/sWcs5JBty
         vVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=qGdwKA9rmdIyqGKO0IjJWKsmKZR9VJYYBo9155sisOo=;
        b=tIloPf0A9ZxYAE3AzzOG6MGHEd0qJIpXIzVt/kYntL+yQZaFXgoFYATlWtOFmhgCjb
         zHlNzjtWhtHnbKzdkLZ49Vtm68o+wpk1MGULmUAlyWFAt5jeaPABJYHZAKbih98DKLaj
         Jnsce2qJCEzLZD8lSE6rYJvDBNps20jLKzYm3mS457iiVLnACu6ZoB3pf+XrUPG2fNGS
         Bl/8DT0erdQkwBff5M6nVTGI8w0uLb6iLv7ebamxMx/lZgdAD1JNbRe4pxhjlUz/WG0d
         eF5Ut1emyz4mA/UGULI30Rl1sT7tNpqJe1kBwiWtwSdVrDlTwdVLoh4Qk8WiIMinNH9D
         8hPA==
X-Gm-Message-State: AGi0Pua3G8vTaihCBkWKdkHjX3wUrPUeEfGhXhenT0rhFeyd3ZhPNvOq
        1wogJ2Yw15RZWQkL+qUlt5MNjg==
X-Google-Smtp-Source: APiQypK9PqT30ndf6uW1fLOStsShr8XNEwiUSzUk9TRlUoeG69t6S9nVpMwjr4mhhaNACQZYeWdpwA==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr13058752wrn.261.1585990402779;
        Sat, 04 Apr 2020 01:53:22 -0700 (PDT)
Received: from localhost ([185.67.209.71])
        by smtp.gmail.com with ESMTPSA id v186sm14900096wme.24.2020.04.04.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 01:53:22 -0700 (PDT)
Date:   Sat, 4 Apr 2020 10:53:09 +0200
From:   Jorge Amoros-Argos <joramar76@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     hauke@hauke-m.de, john@phrozen.org,
        martin.blumenstingl@googlemail.com
Subject: clk: Lantiq/Intel: XWAY CGU support
Message-ID: <20200404105309.0000745d@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear community,

This is addresed to the Lantiq/Intel developers for the SoC's VRX200 and
XWAY in general.

I'm trying to port the current sources to the common clock framework for
Openwrt.

For this purpose, I'd need to have a good knowledge of both clock
providers and consumers in order to update the device tree and also the
drivers. This means hardware (how devices are connected) and software
(what registers do what?)

There's no such low level detail after all my investigations, which are
shown here:

     https://github.com/Mandrake-Lee/Lantiq_XWAY_CGU

For instance, the full structure of PLL2 register remains a mistery and
also its output; OCP selector, is a kind of divider?; PCIe generator is
located where? PMU, is just a gate controller or a provider itself?

I'd really appreciate if you could share some details in order to start
the job.

Please keep me CC'd of this thread.

Thank you very much in advance,

Jorge Amor=F3s-Argos=20
