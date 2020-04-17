Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068DC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C08C21841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfFfOMD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDQU4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDQU4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:56:12 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B06C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:56:11 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g14so760134ooa.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRrSWymYNp23VNv1jflVCfYbLbj0nrTpCLnbz+QVbbM=;
        b=HfFfOMD84P7y8seYdnCWZalBnPjmWIj6Ovtq9JzgmNoE0mia+0qY2a/thtVuXd60+G
         I78iRU215jQlj8Xjws8El1HX01+nKzUDT0XV1aafrejSSGdRXN+jFqEXAPL2HLOFbcC3
         zOwChFVm/NqDuTXQJe9z5X+tc6K9QyQ7eRBG/2Dre8LEf75AYeUVgG5qpu+0P0eHaN9O
         ALndpP14o4dLOsFPBajpEqllZ1212GOOB1QOmfW/hT7d/jzk/ZZr2C3njra9SJ2SoY7W
         EcdFWbd6n5a9o+3KWhsIp7DUFhvgvZyoYCbZrQISdAJaIzTmrHP0hFGxwBhH+Fxe9yYI
         4Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRrSWymYNp23VNv1jflVCfYbLbj0nrTpCLnbz+QVbbM=;
        b=ftNDjoVJxvu50yYIf2wi/8xcH2NE+i4bRXUGdD0GcN5KOsmbGrsTQjvCTMrSJwgpu2
         XZj2si8/SzJb3/FkoJ0O3NV1pF4wj09yCNvvqbfZNJ+zYgWP1anKAK2E+WXdshwCk4cI
         1t/T45EXOWUkgTvTOXaeHTMznSwny2kiLTMuloVygU+Z02wD96YkJg2b/ZhYwctZK3aX
         FXyt2nDU2ndqty9Qf8uuKFLDeA1eWYrSWyOGvmjS8OAQL0KCCQ3ObFQXLmIii5vl0jXP
         0MfRxElvdq2C8ikEKl27drTkLnxt0jefkzP68/K2UFJs0hFPClDqpfDBL62n0cmMUGzs
         QVHw==
X-Gm-Message-State: AGi0PuYyjlYumrirGVJx5DX/PmIIfSLZRNS/hb9qmM1jO/eW4AbJXzyV
        fCQtd32olN12gG+sQO8JMefwTUh7Lt2g92d0fn4rsw==
X-Google-Smtp-Source: APiQypJfj91riCkqx3e93yJnMbbwvx5Qrez6FxxxjKPXXXTo5vbH99INz65O6k0wyRYe+qf5yrs9lpE5Sd16Uwe4tic=
X-Received: by 2002:a4a:9cd8:: with SMTP id d24mr4109456ook.84.1587156970831;
 Fri, 17 Apr 2020 13:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200417165442.1856-1-nsaenzjulienne@suse.de> <500e8c46a9b411aed03965b6f9130ccde457193d.camel@suse.de>
In-Reply-To: <500e8c46a9b411aed03965b6f9130ccde457193d.camel@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Apr 2020 13:55:34 -0700
Message-ID: <CAGETcx8EJiLSV8jzrusim6EvyVvX4H8ANvZaJwO72G1=iS-N2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: property: fw_devlink misc fixes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:06 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Saravana,
>
> On Fri, 2020-04-17 at 18:54 +0200, Nicolas Saenz Julienne wrote:
> > As I'm interested in using this feature to fine-tune Raspberry Pi 4's
> > device probe dependencies, I tried to get the board to boot with
> > fw_devlink=on. As of today's linux-next the board won't boot with that
> > option. I tried to address the underlying issues.
> >
>
> On a semi-related topic, have you looked at vendor specific properties? most of
> them create a consumer/supplier relationship, it'd be nice to be able to take
> those ones into account as well.

I'm on the wall about that. If we take every vendor specific property,
this file will explode. Not sure I want to do that.

Also, we haven't even finished all the generic bindings. I'm just
adding bindings as I get familiar with each of them and I test them on
hardware I have lying around before sending it out. So, there's where
my focus is right now wrt fw_devlink and DT.

I wonder how many of the vendor specific properties do very similar
things and got in over time. Maybe they can be made generic? What one
did you have in mind?

-Saravana
