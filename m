Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258DDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113C32071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgEYXh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEYXhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 19:37:55 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 16:37:55 -0700 (PDT)
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04PNbrKp011517
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 19:37:53 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04PNbmdl004792
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 19:37:53 -0400
Received: by mail-qt1-f199.google.com with SMTP id n33so20641222qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 16:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=0Y4uTL21HCKuXUBHqUrAWLjf+83eCCInE3zQVj/p+oM=;
        b=cAhZ90yedBfruwO5rCGNsQemh8jw2NYIcyGj7qj+A6kN+ov7JKbNDSjj7fJSk8fZE7
         QzZc+PWtEyHZD4TOEaFP9ecUIV2NDq8U8KaXPQEEPylueVOorYkVQs/63azjeQFjsCWw
         U63o3LasES42kC4EOW3eKdXzqeTDD4nLUDcoCt1eKY4f25RL9Nm4lpOAU2DlBkrjWsRf
         le/vKQfQio1ZGn02YScmvUos2w2DZaO1ipSa4/7+JERLTUHxBs82jvbWi0OF72EWQNDy
         zdfCjzbk+TlQv6IOLeIs1YtvhFd2M5XG6V66OkH5rV5qmtToyGYI2wvJGqGZhmw5LwBR
         n32g==
X-Gm-Message-State: AOAM532qUV6NKJ4vjZ88fwLoxBOe1mv12DR35JlVF6ORtsubZmK2TUG7
        4XnO5gUMIUM4UsCy2UbBcaIQjBkauDOBSwa2LY7rndgaEh3IwY0JZ9u73jB8fBFnZ+bOFxv8Cw+
        7L6bf/Lp5KaJFA1muAoccCUZM8jgNAgM0PIU=
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr30195871qtk.192.1590449868447;
        Mon, 25 May 2020 16:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/kIKFi+vyRhQzAcfWv1PgD82LNG4zT04fDiifrOM3PqyiRWxZEMlnOS00CB0w/QJOWPRl6Q==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr30195855qtk.192.1590449868128;
        Mon, 25 May 2020 16:37:48 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id p12sm4199151qkp.129.2020.05.25.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 16:37:46 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, geert+renesas@glider.be,
        magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        sre@kernel.org, robh@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: vexpress: fix build issue
In-Reply-To: <20200524222025.GA3116034@ubuntu-s3-xlarge-x86>
References: <20200522220103.908307-1-anders.roxell@linaro.org>
 <20200524222025.GA3116034@ubuntu-s3-xlarge-x86>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590449865_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 May 2020 19:37:45 -0400
Message-ID: <292277.1590449865@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1590449865_16657P
Content-Type: text/plain; charset=us-ascii

On Sun, 24 May 2020 15:20:25 -0700, Nathan Chancellor said:

> arm-linux-gnueabi-ld: drivers/power/reset/vexpress-poweroff.o: in function `vexpress_reset_probe':
> vexpress-poweroff.c:(.text+0x36c): undefined reference to `devm_regmap_init_vexpress_config'

The part I can't figure out is that git blame tells me there's already an
export:

3b9334ac835bb (Pawel Moll      2014-04-30 16:46:29 +0100 154)   return regmap;
3b9334ac835bb (Pawel Moll      2014-04-30 16:46:29 +0100 155) }
b33cdd283bd91 (Arnd Bergmann   2014-05-26 17:25:22 +0200 156) EXPORT_SYMBOL_GPL(devm_regmap_init_vexpress_config);
3b9334ac835bb (Pawel Moll      2014-04-30 16:46:29 +0100 157)

but I can't figure out where or if drivers/power/reset/vexpress-poweroff.c gets
a MODULE_LICENSE from...

--==_Exmh_1590449865_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXsxWyQdmEQWDXROgAQKJMw/+LVSCrU+vJAzxclsrfbDe/OtM6Q9eNp6H
gLk7jtHTVhF2gxHjIUDO1prxqP0UvjDIdFELT6wPM5tSLbnQ+LR2K4VmfO0Dnqay
zzIhhfyCko81tYkF9vi44SIAQp4fVhousbwJYo5LQ8ukCeIzUgbxPqMBcsJwwZbq
xiQxWuFv5K+QrXR/dPBSkv0DZ+nFjn8oqwo/HwXNeHOj2z/eYepzeG7FW/HvFwfI
MG9J+CM8FPxvsOJRDHg9xP21CyEEGrnj61hQmZ7Otzhlfha5RIcWX/3JfArd2Ic5
sRttZ+fI1g3+q0Sypyw0lYl0R1Sc0/ynnsjAKlqAuUp/hzW/v5jeMByAl1j2YTVO
3QwDA+LhzpVU+erxgYq9B2Aqj38mJ/nBKvUdR8+CNeoAVcoHiYLv5KHy7wBPtF7O
ES+yoq/yc6YFqzy8Um74Op1xgAg13D/wcxW8lfGnZn3IRggYC6HMG0W91CSJ+rg5
xj/uimdjd6AGIxfnQbGZzoJEFOI3TzB3BLOyARliLqZIi1h6OosUATpvVUVqEHVL
dQ95eyBGOzSaJ3LgvmdNbVTE8V+DkiV3y4eAI0F3kpZQqLFBgO13jiWiDC+n6dZ2
ESirUcXrKRR0p++VDXZdMFI0rparnJmbNCmn2u2OHFwaFpe7NYEXY1uBNV0oYYFp
sIubTjf8DqU=
=nu0y
-----END PGP SIGNATURE-----

--==_Exmh_1590449865_16657P--
