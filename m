Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B2C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0667620785
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpytcobA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRSdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:33:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21523 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgCRSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584556386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ilj6BwGd/FajjDOWHuUE6UL+lwbbPzdfmxLEJ0YlHSI=;
        b=BpytcobAxGQ/BdxtrpHiDrS1N4+PxOTMZV3762MoT4k+W8GdDBLCcZ7LiU80cf2C2RXVo3
        AfVFYKA3Ssc4vNxNppm8jycb3zlsBwfEo//ksBwbfKKzaCf8ED0Mhm5EsCtp1aBHi6fltW
        J7P1mD2lMx+G3YwBi1KnpWiVmAppjcM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-anj3paUdMuKD6Cg-tEmxww-1; Wed, 18 Mar 2020 14:33:03 -0400
X-MC-Unique: anj3paUdMuKD6Cg-tEmxww-1
Received: by mail-io1-f70.google.com with SMTP id s2so1295031iot.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ilj6BwGd/FajjDOWHuUE6UL+lwbbPzdfmxLEJ0YlHSI=;
        b=WX61Ftyz6nY9QJhUSb/jV13NZZ6BaAwky3aDlToIoeSHQYnH5XUNX1JVu1F418VCrl
         82QuPPPeCpl+gL25r3RXboINHxdUq6A0zabubBgTPEQ13DgZUn5KroIZxZuGLAPtw/5z
         v6fyrMaDbcy1GQECsvoKqhoI+IZoQctBJVx6JF+cCR4lPEnk13Ct+sLypXoCH9HZMq00
         DOswcPshrEX7IkdUdgEAjHe9Ia5OBnOztUGyI3AumIdvJezPFeTS6bKwZIPfTX8jjGTg
         Ga0qQXlW79kirm0YshbjM6UEubxFUt70P0VuVsLrCz672KFSJH8+ve031riiGbMgSYhA
         vuBA==
X-Gm-Message-State: ANhLgQ1gHYPdzCwUeRJzAGjuUd/KIC9NJW0XtSW1ydM34hkTVx5eLR6X
        rThg8zaKrq/gZxL0afpwqNi2vq0pWSs/viPnrmN4f36ciirQ/BlmMtJjn2cnz+YwLNEVSNQMOix
        yGeE5Q6WSqetu66I7reUTnsZfAbzlSnVWa63E5Xah
X-Received: by 2002:a92:1310:: with SMTP id 16mr5626330ilt.45.1584556383305;
        Wed, 18 Mar 2020 11:33:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu3QMUwdfwhL40iC91mfRLcdXxpcYtuvk362A2+gEvygxz40xZnFroJLFfVNRXMxpk6CmDDAHkI3ym5o5KCFgE=
X-Received: by 2002:a92:1310:: with SMTP id 16mr5626309ilt.45.1584556383031;
 Wed, 18 Mar 2020 11:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200318140605.45273-1-jarod@redhat.com> <8a88d1c8-c6b1-ad85-7971-e6ae8c6fa0e4@gmail.com>
In-Reply-To: <8a88d1c8-c6b1-ad85-7971-e6ae8c6fa0e4@gmail.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 18 Mar 2020 14:32:52 -0400
Message-ID: <CAKfmpSc0yea5-OfE1rnVdErDTeOza=owbL00QQEaH-M-A6Za7g@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: don't auto-add link-local address to lag ports
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Moshe Levi <moshele@mellanox.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 2:02 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> On 3/18/20 7:06 AM, Jarod Wilson wrote:
> > Bonding slave and team port devices should not have link-local addresses
> > automatically added to them, as it can interfere with openvswitch being
> > able to properly add tc ingress.
> >
> > Reported-by: Moshe Levi <moshele@mellanox.com>
> > CC: Marcelo Ricardo Leitner <mleitner@redhat.com>
> > CC: netdev@vger.kernel.org
> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
>
>
> This does not look a net candidate to me, unless the bug has been added recently ?
>
> The absence of Fixes: tag is a red flag for a net submission.
>
> By adding a Fixes: tag, you are doing us a favor, please.

Yeah, wasn't entirely sure on this one. It fixes a problem, but it's
not exactly a new one. A quick look at git history suggests this might
actually be something that technically pre-dates the move to git in
2005, but only really became a problem with some additional far more
recent infrastructure (tc and friends). I can resubmit it as net-next
if that's preferred.

-- 
Jarod Wilson
jarod@redhat.com

