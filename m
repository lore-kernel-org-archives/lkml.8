Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC81C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AAC2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVpVzgVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHGT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:29:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71761C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:29:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s23so2121876qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DwHxa/wKxXJOTRK09zqSMYHbouDi1S4p4xtTraM5iGA=;
        b=YVpVzgVMyxrAA91SMgwq1uRERiYL9d2sigFhiHcc+Gb3HYQOXIe5VdR2+iTSNd3b/u
         8ASMZA8CikFbtPxyCvOQ0Q+/AGlV6EejSTXxHP/rb2zixr7q/nX3ZHgUOcsfo7J8przL
         L9BcRALgg3XDwa7kDV4mx2hYEqOgDymwxsfeKx//YyrR0Urdf1PzBTsthBdBanS/8Eqb
         bdup239rJK1C1usdexrexFv0mi9S2/y5Z7mVnA+7QHANdB7L0f6vffQzhdMhVTi8Utm/
         1ncX4gfpbz82zJ9qFBT/qwBdO7oxwEn8TfHC2XTMceUdXvaIl9yFeFTNZbzq3lC2YxZi
         dxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DwHxa/wKxXJOTRK09zqSMYHbouDi1S4p4xtTraM5iGA=;
        b=ofu2u3qJVtHO9XqUf21TjOH7jUzKrjAw+eG4ZkQ+1kF5HhcZFu6snyIKQfzsYAY9ni
         K73TidVOZi2zqfW3UFYJL3pDu+dewoOlZ27kqgvBNhzxwN+fDGm/vhtIQAGYy3q9Gsls
         8LX6fM7KLusMWf2EVDaOCws68Va7RZqPat2pk05xhDP8Ji6tJxetphc1GrDRjmNElvuW
         bJFT3gGCS3QA/g8pSVBJSMJ/yLTdMGNIEtXRDDwVTzNymoeX1EYXc50Z8b85Rkm+2mIR
         9YI9BSKK0lSHetzUH7giZeiZZcHDxTcQ2rkwwkhKXc0lZJDWWhJkJlcnYnHI5tkrTJRI
         gp7A==
X-Gm-Message-State: AOAM532i6h1vsR8X6r9TfJbh6JIDTpPmIGoMj6Z4ysPPiy1ptUvVE6zR
        d7I2nTnGcDvDEu//KshaG+Sw/Wt5UAMlsRxNySrP/g==
X-Google-Smtp-Source: ABdhPJwVK8YxEVoCQuHZTJcCjYxNh0sSOhQEyT93e5WefGbitF2zu2ak5N7ORZ0X16QJ8/Swbk2HySVmZPk/OP9u4WY=
X-Received: by 2002:ac8:67da:: with SMTP id r26mr15451206qtp.332.1596828594651;
 Fri, 07 Aug 2020 12:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
 <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com> <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
 <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com> <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
 <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com> <CAFLxGvzwoC1GcjJOfwpc8V5LD79=8XiJaNV2HjOm8EdQcCbp+w@mail.gmail.com>
 <5f7ae548-350b-cedf-3c8e-25fea06a8377@huawei.com>
In-Reply-To: <5f7ae548-350b-cedf-3c8e-25fea06a8377@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 7 Aug 2020 21:29:43 +0200
Message-ID: <CAFLxGvy-RRksDvPcB6z8GQUoMFZ_NRGxk9aM2FuTZ22UWU6Knw@mail.gmail.com>
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 4:18 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote=
:
> That's where we hold different views. I have 3 viewpoints=EF=BC=88You can=
 point
> out which one you disagree.=EF=BC=89:
>
> 1. If kthread_stop() happens at line 12, ubi thread is *marked* with
> stop flag, it will stop at kthread_should_stop() as long as it can reach
> the next iteration.
>
> 2. If task A is on runqueue and its state is TASK_RUNNING, task A will
> be scheduled to execute.
>
> 3. If kthread_stop() happens at line 12, after program counter going to
> line 14, ubi thead is on runqueue and its state is TASK_RUNNING. I have
> explained this in situation 1 in last session.
>
>
> I mean ubi thread is on runqueue with TASK_RUNNING state & stop flag
> after the process you described.
>
> Line 12   kthread_stop()
>
>                   set_bit(mark stop flag) && wake_up_process(enqueue &&
> set TASK_RUNNING )    =3D> TASK_RUNNING & stop flag & on runqueue
>
> Line 13  schedule()
>
>                   Do nothing but pick next task to execute

You are perfectly right! I failed to concentrate on the state changes.
Now all makes sense, also your comment before the if statement.
So I don't know how to make this more clear in the code.
Maybe it's just me being dense and in need for a vacation. ;-)

--=20
Thanks,
//richard
