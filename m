Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4860C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB6208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FzaEsvjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgIFOQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:16:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:55595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIFOMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 10:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599401519;
        bh=/6GY+vCiDq3r2TFREQwT9xodDtp5h9Zbvasvf+ukhDc=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=FzaEsvjPu8ITVusA57PsV8g3gSQLZ1y80utQdvs+suN3Y3CB1ZQZFpaxdCyvVYfIy
         zxR4/zurThEuOnGMyAAawI+Iahj2/8nmBC8TY4KA7VYWLcHiCL9FFbDhj0e/k9Yt9e
         8kJVYqrJGrMFaWR3mrdwE9tUAGd491SucyRS/zfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnakR-1kvvFC2Psz-00jajz for
 <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 16:11:59 +0200
Date:   Sun, 6 Sep 2020 16:11:57 +0200
From:   John Wood <john.wood@gmx.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] Fork brute force attack mitigation (fbfam)
Message-ID: <20200906141157.GR4823@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906121544.4204-1-john.wood@gmx.com>
X-Provags-ID: V03:K1:0WGGKJgS5fB4brnA/PN9yNFgS0Z3xvhMNX8EQdRGOiScZx+Sdzh
 qaFnuj8ezjz66hFxxnqsqeof9KpxbaFdTLEeMKJDHmjnmfTJwAHBrwhrZSXXeGwKxtNZhog
 k7aU5VUOJQsP25kfiGcFcD9RUyt/eLUb/CPlpACtM5/QcildxvK+aGgGb9Yd4k4wsuUNZ8I
 M1D/5OKWtGAs66zKEJxnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUIO48j3nRI=:LFu2dWOzrE88OxVlQMwfl4
 DAZFCn2tGSqzDf5ewT+EFEUDxtpeobeq3MtBs/e1cg9MrRo05q1ltATfl7Zgkbam83/EkLXCf
 oseHIRnHOTO6pSWv85HYS9UIru06m/pn/CJQIAx6wlY10sw4penZJDCImBhRMThTu0BMwDyd0
 5YpSyJkKxVgdt4hT4I/kuOZj67fSOyg8Fzrv6Fc4ASr1kD7wQobHBwJ+pMIlB/5c/bHjhxRgF
 EdZJfqxH1LX2tioVDcexpQILD3wNRwt8waBq9zxgF7LUTp1boC59IXJQUcrbKGoRJjpmDbvbl
 yNV1aQpTaogBcjJ/aTmHOdueHrO1zkham9GHTcCm2fd0uV8s8ZUp2k9ypkN9WXueqGedvw/bq
 yObLkZ1+leqKMIHgnSufO/oZ9PVFIW+N9JoxMtHiYhkbVdCnoJW+5miPkfZzNGl/RH3jAWh+B
 QEye7t+EHNAVUUodzp+B9yVJ7xKXrUSAav7EQiCNzi1aOE+Ttx1G51BF0a+wwdvm5NLTRln0Q
 dUJQMB0X/4To6OfUbB3KoLTKNcwr/OE8WrD/shPucYrUip9WT4g24NowX/RBQuXg4YPXAsWlC
 /zYYaln0/cQLuLK59D0gT5eJaxye/bQ1BLoELb/JVvoOQvzKv+T+8NjL0Syjg8tgVMIjiLww8
 W/tKEJDtAPig51SemhvCQ+qE6VswSNjdAO6aaCO/+wBn/xAGKycDIr60vnDRZoif0VPhZKdxM
 CHZtosUw9WfVzieJRY2ZJcUhcGDSjf0JP7xeDOzFJWl6ggf4cc8EQEJih6Qm+6dZgmwNP6cZp
 q4a4CFTYsRoQUY3IyIST2biFJ/cVhhILUYYoMNcNEKjAznUWeZ/vMJfFK+Q22fHJsLgz1aDD6
 46jqdDcomKocJekqsYUi5SLWhdqcn3KFwTz1TX+HE2DpKckVGOwafEIi0Lh5irZCHpqypHZwE
 MzBaQM4ntpVyrh0RCyfkgHnbRy/nwJKrAAJ0E38ccookPnX2eXAlkfx6ox5OoxW51nkUrBuMY
 HCAlvLJTEV0CVZPSwdVJkACHivzcBSXj0aEqfNF1Htk3EwIxnIB+uY45RY4ERONiexafHiDc5
 7zZPV+jtHcsjcdevAVB9huoaqkAhVXiqGtdPITfudPfC9LwkrHVXpDMxB7eLvJc8CmCgAt5I3
 oVTFOoRQLVHLiW8PslDC/3al224KaZMFxeSy8f10L2WLGYdHxz2Uf0jpTac7CT3nKJeOZjeiE
 KKZnED5gJh3vVIsBwNcLACYBD25iLKacGvVQrWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have problems with my email account to send the patch serie  [1] to
all the recipients. My account blocks if I send an email to a big amount of
recipients.

Please don't reply to this message.
Thanks

[1] https://lore.kernel.org/kernel-hardening/20200906121544.4204-1-john.wood@gmx.com/

