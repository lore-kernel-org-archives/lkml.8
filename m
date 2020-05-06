Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529BF20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBGMTfJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEFFEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:04:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbgEFFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588741482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpOKeTMlwPUqZw3AKWDidisP5BlFEm8fe5D0lqvFmu4=;
        b=jBGMTfJ/M+jJ0AA5iDC7rSc5aM30aXMomjTwFIZqHfop9eVh6Qe5f8uAeBDbzj+igmcrKm
        MJA9qks51W1MYXjoloqQbzo8h8eL571Ph1vjOgrEjWIXvmG5k3ZCWTEJi6tlGDv+nV78QT
        +3KLvaPpAI61qe8xR2msdITW02tvXKA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-wTHTyUZBMNSqdr6nLbx6ig-1; Wed, 06 May 2020 01:04:40 -0400
X-MC-Unique: wTHTyUZBMNSqdr6nLbx6ig-1
Received: by mail-qt1-f198.google.com with SMTP id g55so1012139qtk.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpOKeTMlwPUqZw3AKWDidisP5BlFEm8fe5D0lqvFmu4=;
        b=rG3XTbhP2cvEwmgQRH+BvpoSTCuNKSZ65qd83QvlGLccjGk/MqCeNPopWN5ZFrZaA3
         b2QOhDa1S1KkuvcUkS5uOFw9udrgW5jtqbC9NGUKi69xppNXe36Dg1RFt4zjSs5ZOstu
         Crp70KqIYuVQItRK/IZ3bTKR68zjh83CMwgY8xScdgjFTnTJn4QSq+GHBZ5GeEJWF/zc
         aUejVhrEUUvPDhUwuTKffnZm+Vf0t5N6xrHNwnbdvwJZ1M6nUt5w92rRyvZajoSrCtJC
         AzYLV20kMmrQgWu1abTBOAX/+5S/5L/yht1tJLsmIIFjzNl96Iim7ORMOFv9To15jCeC
         Yn2w==
X-Gm-Message-State: AGi0PuaOLEbAqiZRuVPn12A0YQGuQbWz0bkpqEDi7e9nVyQiSoFa4PGA
        xjm6gbfuWfk4v+Dewbg9gFElJAOF4Kp+Oj8TFQL/r52M3WZdqGRb7vnoB/6KD5bE13bo5uPzfIA
        Yae14XUTAl2MGOCKHqDoijgo9ayDOeUs44Q9cZvVX
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr6188940qvv.198.1588741480448;
        Tue, 05 May 2020 22:04:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVGmiq75u5vfcC1Iokiaz06crzjYhtEhd9qQagiN7lp4ZFJMlbiJrqHX9jd7sPmdUaT01LbgKV0sF/zJSstwU=
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr6188915qvv.198.1588741480169;
 Tue, 05 May 2020 22:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
 <1588705481-18385-2-git-send-email-bhsharma@redhat.com> <20200505.142439.1075452616982863931.davem@davemloft.net>
In-Reply-To: <20200505.142439.1075452616982863931.davem@davemloft.net>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 6 May 2020 10:34:28 +0530
Message-ID: <CACi5LpP+47EEO4YS6TCPPA4-xeu6phXV2uz=8bfWdfggwC73Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: qed*: Reduce RX and TX default ring count when
 running inside kdump kernel
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        manishc@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, May 6, 2020 at 2:54 AM David Miller <davem@davemloft.net> wrote:
>
> From: Bhupesh Sharma <bhsharma@redhat.com>
> Date: Wed,  6 May 2020 00:34:40 +0530
>
> > -#define NUM_RX_BDS_DEF               ((u16)BIT(10) - 1)
> > +#define NUM_RX_BDS_DEF               ((is_kdump_kernel()) ? ((u16)BIT(6) - 1) : ((u16)BIT(10) - 1))
>
> These parenthesis are very excessive and unnecessary.  At the
> very least remove the parenthesis around is_kdump_kernel().

Thanks a lot for the review.
Sure, will fix this in the v2.

Regards,
Bhupesh

