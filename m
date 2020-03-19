Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B06C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D0F2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhFaroa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCSSuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:50:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34429 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:50:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id j5so3873676oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBBTCQZKvZ6z4WK9Xo1ZHxbyAdL21+7byNbe/ZRuw0c=;
        b=XhFaroa4eCglvWBaLqoGx9MgoSQz08cJbXAW+83d3oq38J3kmKbdac+qe8tbsyz94f
         fde9FijEu0Pzf5ZAlj3fP+vxLSdHGeuVBdAtLpmPCnHONapIvWZtlQMa5MHdKDcpiJ0C
         TQaPnJ6G34x4x4Cry5MRohLUZfdeJp128ssM45FGAS7+Tdy9+di26+87e5KE1aFT4iz5
         0Zp/ALBc7761shhRrNpVICP/w4M9jwwI3lsb1/l+ogXAX3QsvQP+JG/Z89FuzVpYavN9
         v+lu/05VA57PfymQrFLy2eDtyisWBiFnwivFX4Y9/LQmUW3+9ARBhu3XFhcIAKAzDVkT
         Q/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBBTCQZKvZ6z4WK9Xo1ZHxbyAdL21+7byNbe/ZRuw0c=;
        b=oTvuNXO8/HkKflDF34fOYiKXVIf+YU3BHsio4aeUd2wWNUnQUNxwfIJk9eLWjlkk7r
         h9w5do4gNJllAoPLoTVNJ5Pc7aVS4L6RSNP5MgtudXyU/0Jwy5iFD4BTQM6iLhZXdOQx
         14nAPIhopgDFPb6Tfo2ukzd0fxiJ3jGyJIhseocyNjC4ju3X2X95fG/4HJwO2n8s2uhd
         Y0dMJx+kx3/aFk+bHU8LlENeVs1pCIkTTvdNU7wtAwpzQRcjdDFr34x4GmerAgUUQehD
         eceNdYxTrtH8zx+s4MB9pv1N9xD25YMm9FQkoAsWueYQN1ghOY+o7v878IqeETlYsekH
         vDwg==
X-Gm-Message-State: ANhLgQ3d0NBVDHlqZcChpkTouCV42yg/FYlFpTrQnwOcBNeDakYU/chg
        9VHw2RVmf1Xb4PLzz3zBZRnYDryYAfS8csbFlasdEw==
X-Google-Smtp-Source: ADFU+vuAW/xF8TkO8eugnikWDkJB3BbwaXLHQAim9ZR2gRbQodWFKChBMp92mydkZkVObyLhhkazzZcB5/RxEl5bXFs=
X-Received: by 2002:a05:6808:48d:: with SMTP id z13mr3348154oid.79.1584643804372;
 Thu, 19 Mar 2020 11:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <1584599549-6793-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1584599549-6793-1-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 19 Mar 2020 14:49:47 -0400
Message-ID: <CADVnQy=FGds+0DLeqg2hZ1Z3gWGp41WNmiJf9hVaLy0NwbieAQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] tcp: make cwnd-limited not affected by tcp
 internal pacing
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 2:33 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> The current cwnd-limited is set when cwnd is fully used
> (inflight >= cwnd), which allows the congestion algorithm
> to accurately determine whether cwnd needs to be added.
>
> However, there may be a problem when using tcp internal pacing:
> In congestion avoidance phase, when a burst of packets are
> acked by a stretched ACK or a burst of ACKs, this makes a large
> reduction in inflight in a short time. At this time, the sender
> sends data according to the pacing rate cannot fill CWND and
> cwnd-limited is not set. The worst case is that cwnd-limited
> is set only after the last packet in a window is sent. This causes
> the congestion algorithm to be too conservative to increase CWND.
>
> The idea is that once cwnd-limited is set, it maintains a window period.
> In this period, it is considered that the CWND is limited. This makes
> the congestion algorithm unaffected by tcp internal pacing.
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---

Thanks for sending this patch! We ran into this bug in our team
recently as well, and have been working on iterating on patches to fix
it.

I think this particular proposal in this patch does not properly
persist the max_packets_out until all the ACKs have been received for
a flight of data. The consequence of this would be that the cwnd does
not grow properly in slow-start for cases where the max_packets_out is
high enough to merit growing cwnd, but the connection is not strictly
cwnd-limited.

I'm a bit busy this week but I will try to put together and send out a
proposed patch ASAP.

best,
neal
