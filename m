Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6051EC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3617B24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu+/v3Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBSBQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:16:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47018 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgBSBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:16:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id z26so15959235lfg.13;
        Tue, 18 Feb 2020 17:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wY8tmCeomH+2CMXN5mHxilagcJPTVU/h/N92RgKMXss=;
        b=Gu+/v3NjcRZtBiv5DmlQqHzr4AewHLDSAbUqL+Zxa5E2ejQDleUf1EnaANRzIZznwh
         YqV3QnvGw1pAAoD6W41dhvHtGXJ66SN5Z3EM0p4IPGVKnjLtHCrqsVXCqpoNLtLPj5UE
         XDw30nuqvMkOdDA22mirPDLs6pIdp0bUHsUfkpz+7ikB3xNYiBa2xoXoXtg4asKBZQb3
         cjcRpWowRQAuocVMmtN9ZdrxHuHN6IkgIXCsl1ZPMAn1UTz+7V80mYlZFHGIvrtJ2O4G
         VwXBEQHpYfpNEc3YUi+t42a+YSVBjJ6l9XCCWdliWa+BLHhaRNM3gUX4H8FgYa40N7o7
         +G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY8tmCeomH+2CMXN5mHxilagcJPTVU/h/N92RgKMXss=;
        b=KznzNKuonBKR3iPaQk9HOcO1Pj6dkYZh/mC0bT5P6Jb4DBRPqQOI5A/6KOXnLogr/m
         Nar4e5swpCWmOi5nUZ0pcETPAF/tuJ/JROffgiwZFNCxo1txUWkKU3KIjxU+AXKcEZJ2
         o6GRzU25plqp/RfzvE2W34w/c3p3XHtn2tOF6w3JafBIG7hEyUYfqzOP1Ylgb5AwsgAu
         Gg6O507xwtHvtiKQEBnD/pelrDes0K33ZeGYQYCGQ7/oob2liW6zeO5FbYpK0JF/rB1N
         u0wga6rPTKzP/th+Tq1kChWpa2E700m5QodrM7IE/cmJ18vXQ2C4Wd/BAU2fn84eqDFX
         w34Q==
X-Gm-Message-State: APjAAAU1mIwPcqXfQtlycfzCkCEKQ3P27ZIT0DG20uzjCsfwQCXuY0j8
        2OZ8QdKlw6EIYsmY6FbGKLfqgHp+zZwiKSbJi7k=
X-Google-Smtp-Source: APXvYqxjq2N8f2rpbY+y1QlK1Q5r+n8Rpg63NNtE33PzTaUMA15ziWWSBlLGXiYl0tmfnzeip5wD6o08fyU6O2qcdgI=
X-Received: by 2002:ac2:53b9:: with SMTP id j25mr11592316lfh.140.1582074988296;
 Tue, 18 Feb 2020 17:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20200214192750.20845-1-alifer.wsdm@gmail.com> <20200214192750.20845-2-alifer.wsdm@gmail.com>
In-Reply-To: <20200214192750.20845-2-alifer.wsdm@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Feb 2020 22:16:17 -0300
Message-ID: <CAOMZO5BzoQYb10Nr54w2miqk=zCiAWopVg-2trxw=T+cot_nJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mq-evk: add phy-reset-gpios for fec1
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 4:27 PM Alifer Moraes <alifer.wsdm@gmail.com> wrote:
>
> imx8mq-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.
>
> Describe it in the device tree, following phy's datasheet reset duration of 10ms.
>
> Tested booting via NFS.
>
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
