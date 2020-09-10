Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC93C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449392075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="hS3ujk0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJQlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIJQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:38:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99960C0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:31:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so7406598wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8XrenaZC7x7EEzLKgWnRWWP3kw9ET6fFDlth4Zp/gtY=;
        b=hS3ujk0SNbO+KKIhwCtkhoaR3D4iaqKNbu5obxXUIkUAIZEavvzLtR/AmkXCcWoApD
         6qpvZyIpj9MYpkAyH9G8uDL9NSGEi/1lDmYfV7LcqkQ60EBegndDFNwM8JmtO545n85S
         MOg1C3tt9lgEWQfDFA9RZTtn4r+yEtCoUD0KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8XrenaZC7x7EEzLKgWnRWWP3kw9ET6fFDlth4Zp/gtY=;
        b=eCdVSUYoEiCJXy8c/XK0a0bZe50Pz2h/irXZTPOMPOctDrFyyE8XLcab8WAu/wjWd8
         V3f6qlKhpU5xnujmgvNc6R5g1WMBPQOlLwV4F3z3Gb/g97TcWDcdSr9F+kVT6mBNwV5+
         Qkjmhp1WbO9REjHyqfky44Her4OtvJgrgAQX903TQuuza4NncymgPer69EASv556L6t+
         /4UDKMUMyw+KLguqnNJC+eiRkm4qeBV45rQNQG6YzhxsfXP+KKtmnVtWZunRxu7uox00
         f27kRYl67uuxqWWIOKJ9oKeq2FaMC1ruJ6ZAhterrfNqfjSZFsc42wJOJsijon8uYAZP
         HAwg==
X-Gm-Message-State: AOAM533v87j1/wz+Vh2P55R51kf93nrRlDr8HWhLkAaCOnkh8Ya3O0bX
        0Habp8oX4JgCqYrbv0M6+wIndXshejGJXS+Kfr4G/w==
X-Google-Smtp-Source: ABdhPJwcM1WR8tf/ZS8yQwLpBis3MuAq9iXnzyvBX/Zvx2Mb7vIdbYBdQkdSZNftBa2+3D5j79NwEzxaMX89slqGZpY=
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr10703282wrx.182.1599755508951;
 Thu, 10 Sep 2020 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <f79159af-4408-dc2f-6efa-45c5b45cf2d9@web.de>
In-Reply-To: <f79159af-4408-dc2f-6efa-45c5b45cf2d9@web.de>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Fri, 11 Sep 2020 01:31:38 +0900
Message-ID: <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
Subject: Re: [PATCH] qedr: fix resource leak in qedr_create_qp
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-rdma@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Yuval Bason <yuval.bason@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comment.
I will re-label the goto statements and post the patch as version 2.

Thanks,
Keita

2020=E5=B9=B49=E6=9C=8810=E6=97=A5(=E6=9C=A8) 22:24 Markus Elfring <Markus.=
Elfring@web.de>:
>
> > Fix this by adding a new goto label that calls qedr_free_qp_resources.
>
> =E2=80=A6
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> =E2=80=A6
> > @@ -2165,11 +2187,13 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd=
,
> =E2=80=A6
> >       return &qp->ibqp;
> >
> > +err2:
> > +     qedr_free_qp_resources(dev, qp, udata);
> >  err:
> >       kfree(qp);
>
> I propose to choose further alternatives for numbered labels.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?id=3D7fe10096c1508c7f033d34d0741809f8=
eecc1ed4#n485
>
> Regards,
> Markus
