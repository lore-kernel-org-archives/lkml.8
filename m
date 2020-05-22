Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BDAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889C820885
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT1NJtP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEVBg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVBg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:36:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34390C061A0E;
        Thu, 21 May 2020 18:36:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so10703654ljc.8;
        Thu, 21 May 2020 18:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xe8ItSV7TWpuJ0Sj6ABqt9kZYzEJBCX+NyG4cgDQbwQ=;
        b=rT1NJtP19zASFzi0kLE9ovS9c17j+Xs/6AJSG7rK4TyrUn1MKdmSCXF1heoXnCLp7v
         1Jry0RUhwUvjEoDaNvowlunPUXySy20/0anhrmpg0jkII6/AcwE78sb6B6Wi0qDxSdi7
         kSAfW6DRkpX5a4OlT4AFrBbie0Rtsg5AQ5hvHOdEJi4wri1BBLJzEKgmXRninYDNWneP
         N5vEaIx+eXbYvWlpyifBDefbVzg8hljn2EaN08r2ggbEo+3htywlRdYCwuVp0LcPuNHW
         UuZwnZZdCqrUUwrW3JmJF78l2m5E/VXss8pH+Lu6wQvEx+86+bv1fRQU4VOkBHIJl0Fg
         k2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xe8ItSV7TWpuJ0Sj6ABqt9kZYzEJBCX+NyG4cgDQbwQ=;
        b=m03/bTyO2X0MIMn5btMgJE6GK9vENLqeVuK4Aj8yVHGPBS/b9+DBZzuLzRbdRckLsX
         WlyFgj/fnknJO07xmJxM2kWIHt6xAFv/QhEcY9abajWnWNTgWE9AhMWUPs5WHt3TVtab
         WfnOfz0Txwen+R2zVk8324aXMJQ3DGI+KhLzxHjwOPFagBjS8cnVrXbJAVPPyFBgWzF8
         bfX3hI3zsEnjVliN7dYKHESKRIULCGQnGzjPotL6QnRwsv/q17uVq7Yan+QkWJPvzsKx
         N6tNn4YJCvgPTn+nd/I4shY712VWnfgOwWFLEv5gRlSJfIdN4hIqvjyK/OG11GVL1/MW
         j5sg==
X-Gm-Message-State: AOAM531KKE8KASly3mqpkUfqpsYCDnA2ec0oi1T16xZyD026nsGRmTVa
        v4wGQeYSuXoeE6u9+XwN8q4K0WO+Rn5ivLic030=
X-Google-Smtp-Source: ABdhPJz4ng85HDuCoXa+K1Pjzh5pnjaHSdLkxpp6ptjdi9kX0Ew+8Xac83dsBEF9SPUCrIBAXJFkj7uXZNxX6Zf6bIA=
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr4936909ljl.178.1590111414634;
 Thu, 21 May 2020 18:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590070674-23027-1-git-send-email-yibin.gong@nxp.com> <1590070674-23027-2-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1590070674-23027-2-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 May 2020 22:36:41 -0300
Message-ID: <CAOMZO5AsCREw1OT5zzFH+pC6uyw+MOSKJFZ3_-HvDva65A2cKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yongcai Huang <anson.huang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, May 21, 2020 at 3:17 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> Correct ldo1 voltage range from wrong high group(3.0v~3.3v) to low group

Please use capital letter V for Volt.

> (1.6v~1.9v) because the ldo1 should be 1.8v. Actually, two voltage groups
> have been supported at bd718x7-regulator driver, hence, just corrrect the
> voltage range to 1.6v~3.3v. For ldo2@0.8v, correct voltage range too.
> Otherwise, ldo1 would be kept @3.0v and ldo2@0.9v which violate i.mx8mn
> datasheet as the below warning log in kernel:
>
> [    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
> [    0.999196] LDO2: Bringing 800000uV into 900000-900000uV
>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

You should add a Fixes tag and Cc stable on this one.

Thanks
