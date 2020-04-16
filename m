Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB30EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A9021D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rb4MJ2so"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394749AbgDPOtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387540AbgDPOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:49:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA9EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:49:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b62so21530506qkf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30WpPuLdsF1vPq82Jwx+bqfIHjpFy3a2O81YCQ5FRFk=;
        b=Rb4MJ2soVuS3pxrQpUJyV7014U/EyLQdwxDlP4RNzfbWBzhK020e94ngMapWQ9yXLi
         2w4BC6C0UiYkmSht9qNyTvxZOpH2RL4qVHug9Iau2Dc40AePEen3KdMDSIHrrCWFRY18
         yR/g77B8VwU3H33ktg90f4Zw8OmbVLd2IitE0oGPk242n1s9MWm3flNCtIt5R0CiVy2r
         pssMup8LaW/A0bdHYU9fpK+myRntemkAfYjmtDwgAJaFXlk/b9AJnUmobBmkBzHZiwKC
         yIW64yJpc14LcKp2+RHJnTlH1yl/R8RTwN7ZW/tH++5rrkm2FqirtXOSqtwloQj7PElf
         piQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30WpPuLdsF1vPq82Jwx+bqfIHjpFy3a2O81YCQ5FRFk=;
        b=kFAWrJxkec5cOtr170SaHyXHWm9fqD/MlT79hv6/mPz5Cwpr2wfYeDzV/DlZ+fCZgG
         azgwAX0DZ5nK1fqA1FqLpKKsvRTkxqDwtUIe+RM+Acr0yVfLQ8I1XfIZTtaA/AQwi6Cz
         triIVo2KNwxzmFkgWiMJlWQLe8OlNA9I5nwsayH3NAcM73ClWTiIpi61KLq9eT6mLqHD
         wfPh4NXhnnkylQAHEvQvniIqMgbbJ9I630larmwtUH3Ggr1A2VkRRrXwWUbEOc+R+Lpa
         xg6nRhhoy6f+qPDZ1p0K17yoSfKtEU35gq60i6ILyyvjHYCYP8CNuuvadFoddcefOm0A
         Yh3g==
X-Gm-Message-State: AGi0PuaAyq/DR6psFc4ZpU5cIQwyS1IX+eq2vi7SvtvNHguN1FPeu6nl
        brhqh1vQX0fT7kGCQYYe3F/J2B3/eY2OTA==
X-Google-Smtp-Source: APiQypK8IXkQ6uYwp63LhOfNah5+ZsAL/mkzxz8fRjRohseE/Bnc+/B7EI8A6yTW9tLsTCmGAnRXug==
X-Received: by 2002:a37:5004:: with SMTP id e4mr31691259qkb.18.1587048584130;
        Thu, 16 Apr 2020 07:49:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c69sm858670qkg.104.2020.04.16.07.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 07:49:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP5pm-0003ul-HA; Thu, 16 Apr 2020 11:49:42 -0300
Date:   Thu, 16 Apr 2020 11:49:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Hillf Danton <hdanton@sina.com>, Peter Xu <peterx@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
Message-ID: <20200416144942.GQ5100@ziepe.ca>
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1>
 <20200415031602.22348-1-hdanton@sina.com>
 <20200415142546.GO5100@ziepe.ca>
 <20200416000229.GA9922@redhat.com>
 <CADyq12xg8vxetG8y=M6i2m4qYrtjsRhmpds-3yKTY2icrHG2GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12xg8vxetG8y=M6i2m4qYrtjsRhmpds-3yKTY2icrHG2GA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:15:26PM -0700, Brian Geffon wrote:

> And all of that I guess makes sense in the case of a non-blocking fd,
> but what about the case of a blocking file descriptor? Both
> userfaultfd and eventfd can seemingly be stuck in a read syscall with
> no way to break them out when the userfaultfd/eventfd has no further
> utility. Here is an example:
> https://gist.github.com/bgaff/607302d86d99ac539efca307ce2dd679

If an application wants to terminate blocking calls it has to rely on
signal delivery or pthread_cancel to end it.

This is very complicated so it is generally better to use poll and non
blocking.

Jason
