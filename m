Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7ECC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F0D20757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588092824;
	bh=MW6U7i6dsChyfAHljQVchcy65VGcsk/6Oq8vcclecP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zYMqWoPHG1+aDGmMsVWoTdjtVjNrVczenOK8+FAmqENjAJXcWjiEHwrJ5MkJSoz3G
	 iBVkPqFmTdFwDu8HX/rsqdrvXIz4PsPIDnFPozoa71RPUiPvLmSKK9F59VYrSf2qsL
	 5fDtTyY9jwtT8QsiOURn2s5kVzknf9Q7a9M8UmzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgD1Qxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgD1Qxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:53:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E746AC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:53:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so22268498ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5Z4HlhTNB53SfOmbfxYbxhFeMg9kSBe7UiylTe1sK4=;
        b=U0vubYq04Lq1/qZe+lISORyl0P83N1X2JC1zPH/anIzO/2qgQ9RdChTPhMz9JkQYQN
         MMuZWyY2quEr7OcLglD7hQLA6m85JwzjLomr38fhVcQFFEJcRWEnwXzAfHtni2RnkvwQ
         x6lDYp88Dq7d9rzV+kA7s7TFN7/nBiIe2xQ8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5Z4HlhTNB53SfOmbfxYbxhFeMg9kSBe7UiylTe1sK4=;
        b=Wrx5qGz82HkAE2u9ZWdtU2TvFmaV9NN9rKqyAqdMc+dux1CZG70K3W8Ya1N6TTb2bg
         EsHbZKQkUDWM9RhNFe6u4u5tuW0BAssSeFLusGwCx1EAEAqNQjbzhe4lJotA66L637Kb
         3mO5AfG3zJ2+jSusZdaT9lnspRzqcPteLiVI/fW+fpWohoN/c4vkIJ97GEm+2M/mRral
         VoL22wyEtnA9kkJMAB2IXqTMKs1L4cMAVtQdhTN/g+AdHChTy4vzBQn5P2gTortcxmO7
         LZON8L0SWtb40pt62qDX7bjmccdrWODy27lrzUYrf5q3vM70rKT1W2kLhL9I/JPgkbx7
         3rMg==
X-Gm-Message-State: AGi0PubK12IRBbh7Ibv77d3yomluYc/YUGGImJUiCYVhhArHv2cND6WC
        FrpeEIuEl5Zjy4qJLKv5QMaDvuiTitE=
X-Google-Smtp-Source: APiQypIM3KgZoLR+Z4K3VNyvqzy192XMB5jtUnrL8DmdTGeSNJvqvwx4YYoWFQzLH0+i5dc6IaQtBQ==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr18312262ljo.127.1588092820460;
        Tue, 28 Apr 2020 09:53:40 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o20sm1003290lfc.39.2020.04.28.09.53.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:53:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id j14so17490426lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:53:39 -0700 (PDT)
X-Received: by 2002:ac2:4892:: with SMTP id x18mr1932440lfc.142.1588092818583;
 Tue, 28 Apr 2020 09:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org> <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org> <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
 <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 09:53:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
Message-ID: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 5:20 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> In short I don't think this change will introduce any regressions.

I think the series looks fine, but I also think the long explanation
(that I snipped in this reply) in the cover letter should be there in
the kernel tree.

So if you send me this as a single pull request, with that explanation
(either in the email or in the signed tag - although you don't seem to
use tags normally - so that we have that extra commentary for
posterity, that sounds good.

That said, this fix seems to not matter for normal operation, so
unless it's holding up something important, maybe it's 5.8 material?

                Linus
