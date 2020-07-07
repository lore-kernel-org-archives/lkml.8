Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E06C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19D6206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLP+5VBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGGQam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:30:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DFC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:30:41 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so14158843qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti/+hZiOquvF5N2JLhYOzuH+AIpIHJEt/nDYOxccwps=;
        b=qLP+5VBPQz5ox+9pAMpWmJbxG7qvfMXwFt1ZVAS40taFtFVS2G4AboXtjtfvafVeK7
         qQjX73lv2CvlbFf0DPfnQTRpbZRXcc2MDuONjES3ebATEyWvXBFjKShxlYc2dFgUp+8O
         KF45M1p7f8MWV7XroKuY/3a9TwJBofCnqXqG5WK3Tpea5+xXDzcQr32Os+98ZLbFB93z
         +ZYF1nZimfd6Gr7RDkfDhpXrJe39QcXby4Y55mFEtswkKBelC0/WJenSV8m1ZTwHa+Wo
         DKc8T+6VbfqNibRIfKBUjl8kjv6AY8brZTM4h/KroBNHslFbOwtRodDbIx4fX8vSLN9B
         DhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti/+hZiOquvF5N2JLhYOzuH+AIpIHJEt/nDYOxccwps=;
        b=neKXN1n81xMpTNk3WNXnM4pqgFW2xk6EnHQmdPvMY6cKKysmX+GmnyQdpCgZ1v5w+B
         GkWyY7+o94tOsqJH3A9p+Sd+DhHx10/MM62ZZ1pCGhdix2zAbOj/oB6NXWW726RaF2jF
         mcHXBSWmHthlxG/AuuMXBp0DAKFAloRNESqisQ1v9a1TbfQ4RXbV5Kz1nt+YJqb9+Y9c
         qsa5lrZT8vY8vMUPtTD58giU72vqM4faWxzLiJP1Zu8PpfcZZ+f/+ZYwXyh0jI0U26z+
         K7MRIXlIL/p5VZSDFAep3SncMClByrqIT8LozNj8YXQC5rG/QqD16v37qJeV+3xqoKb5
         P2nw==
X-Gm-Message-State: AOAM533XwnspmPlS9i5QFlgzm/8jo09Z+ndEmU7/G+6N65aUrWzHW4v7
        eFiRb37P+KNxGjdmh/w6JSfElBc0e3riO/i3DQo=
X-Google-Smtp-Source: ABdhPJzFd5AWBG/kEeF/s9VNCdKXRs9fzrF74RxtC/PKZSPqDvtMtuOPN7uCe5MFF4We5LsuMqNtnbFuNYTdkShwCH8=
X-Received: by 2002:ad4:4903:: with SMTP id bh3mr53168588qvb.17.1594139440905;
 Tue, 07 Jul 2020 09:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200619090635.58548-1-lizhe67@huawei.com> <e0d04d70ce674584a71af1a5a00984dd26729891.camel@infinera.com>
 <dadc539df01b17aa5dc85e7c0f1dbc83591667cc.camel@infinera.com>
In-Reply-To: <dadc539df01b17aa5dc85e7c0f1dbc83591667cc.camel@infinera.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 7 Jul 2020 18:30:29 +0200
Message-ID: <CAFLxGvzP3AuZBJ3RugZiRTobxv3Z-kxYKnBUi0rfshwf7GuuCA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: fix UAF problem
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "richard@nod.at" <richard@nod.at>,
        "lizhe67@huawei.com" <lizhe67@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "zhongjubin@huawei.com" <zhongjubin@huawei.com>,
        "chenjie6@huawei.com" <chenjie6@huawei.com>,
        "wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
        "qiuxi1@huawei.com" <qiuxi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 4:08 PM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> Maintainer ping ?

Whoops. Applied for fixes.

-- 
Thanks,
//richard
