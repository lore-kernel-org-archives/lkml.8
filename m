Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8DCC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586A72084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfaAgE8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgAOU0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:26:11 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:46220 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOU0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:26:11 -0500
Received: by mail-il1-f173.google.com with SMTP id t17so16005299ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iQ8pBplfJf3QXQ6Cld8WTGD1ayy2UO6V8CK3FRxpWJI=;
        b=XfaAgE8TMBjf+u8PUWX6qkWOlqTAqIapHzrmTOI9Sa5dxSIApOcHUyDHF1CYGwJ0TK
         9gIgbcSEg/9UTPu4fkWAUAMozQ9utiowCewUDlttN1yJQoXF+xc4uC+cwfwzx9vTCVm4
         XXV/EirUb4kr9FJY7t1DwFdA42v1eSvPbO2Ev98LmxpQATkgKiNukTQZBwoLbPmiptjE
         KjlMf32IlGmVPgrYGyZSVEjM9SiuQsaUwP3xaArVY8pnVaOWeXrg9Lc9D5e9+ve4Ttx2
         O80R0iGUKcpGBc8VxJcNdZRbxJY7WZSRw8CbEpP9O9nbh++r8jjdJXVfs7YMCVJ0jnq4
         cAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iQ8pBplfJf3QXQ6Cld8WTGD1ayy2UO6V8CK3FRxpWJI=;
        b=EEdN5VAdoXfOAsdk535JEvGcWppUDpiFLQ19Y2f79VB/18h/3z4mvWaChRHkuxoccA
         RM6tJ2ziZnBRAxj6C0cadp3X4Q+ah9Z18Ic9XoG81bBmjlfErlfyJVvh7WqodVkeZTT4
         n/XO96pSBP/FSiZfkeAJwk2akZoZ2a7aIcGhq4prrurfLoNET1X/5G5Om+iL5HlLILqX
         wuInBJzV6eJgzl45Ws6YjTbjgdw6eXOHd6pI1rwdCJ8FpIoRf6hoAQmdEYspJY10A2ty
         eNhA4ADsqSZs1HqVY3uGnzUJ9Sv0AV9zRX3El6+TdhlEfWeV9HB8isdHdABt6+f7UI2O
         acHg==
X-Gm-Message-State: APjAAAVZgIEkOn/f/dQseOM7LeVHeJobDMjTkgYkX3kgWix2i8giwqfm
        d7cWiJKcUM+ZpjmlO4zVc4f2BXTbD33GFevG+6Q=
X-Google-Smtp-Source: APXvYqyOKorj9F79h2OthPLRfItZTQrx1bIwSVZts268Srd+0UB5q3ZUgPHdhRHzsUqX8Y5yUdNQ09eUMWJm2lyDI9g=
X-Received: by 2002:a92:1547:: with SMTP id v68mr330617ilk.58.1579119970226;
 Wed, 15 Jan 2020 12:26:10 -0800 (PST)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 15 Jan 2020 14:25:59 -0600
Message-ID: <CAHCN7xLuCqSFVnVQ-7ZWH-Dkd+w-_bJLnbSDyUip_8orhTwzZw@mail.gmail.com>
Subject: Using Pull-up resistors on gpio-pca953x expander
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pca953x can support pull-up resistors, and I have a pcal6416 that
I'd like to enable them.

Ideally, I was hoping there would be a way to add enable to the device
tree, because the expander is connected to some buttons which are
grounded when pressed.  Without pull-up resistors enabled, the buttons
always appear to be pressed.

Is there some way to enable them?  I see the functionality is
available and called through gc->set_config = pca953x_gpio_set_config;

I don't know enough about the API to know how to enable this.  Can
someone give me some pointers?

Would you entertain my adding some device tree hooks to enable them?

adam
