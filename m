Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F68C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476D120675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLUvqXVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMOHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:07:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbgHMOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597327630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGXP4qw+AnPxVdaG8af/8IcGg0r93+iBSNIWSEPA6j8=;
        b=QLUvqXVINTXUM8ERNWq/oNzrDPpO8amLPEPmWHRrtlhf9fI6E3gfusAOTIzTu+8LBMxDNm
        QER24JuYaUDER3H7gzjSV6yys+g1zBoydbXft7GQ9295jbZtmreJtOQm/0qB1bL/JQ90ml
        A52klH09zL0qhjPXeoxI+Dz5Xmm26Ws=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-dZkGXCqRMbyriU9pqb1ZNw-1; Thu, 13 Aug 2020 10:07:07 -0400
X-MC-Unique: dZkGXCqRMbyriU9pqb1ZNw-1
Received: by mail-oo1-f72.google.com with SMTP id r66so2881085ooa.17
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGXP4qw+AnPxVdaG8af/8IcGg0r93+iBSNIWSEPA6j8=;
        b=d+9rZ1GM3NEZSjZ1M/YBqFE8w0Q9UIEwxJ9zk2sLhvkVcpIQHQsPqBz4MqY+quY6+7
         Q46Stq5r2o7KNs3nDOkCGnOZ3fmpu+VpjGNjr187hZye0Hl4YF+qLU4Rg5hk9MkudqOz
         HftgWAJNNVCxDww/l0R2x2KrN8s7ewhSTZgdBENv9aNz6o/kzXsOzPbLWVHq1+5a7iIa
         AIeHYhydYGCHCrhDx5Pu1/EmPDbR6ju/MGQLMyVkz+Y8eSRakca1Ne86sUE1cGGPjjes
         bYIsLateAyslIjQcNG9hFxEg6rcTVnJvKFkJfbYInJXS1KDHZSc3w8lzOltHJandM5AB
         X5OA==
X-Gm-Message-State: AOAM533RRkEu2r+/mJzYYSO6vytExRyez6iOFD7D/uObluAfFPXGGMRH
        0Av3SA6n2UPtvBjwr7ROphTpmdXY+ECEC/KCvQ9sUB/WrYL+FknpfgKakL8BNxEHEnVZoAgGrVi
        lCu2XheVqRtWcnuuF5ewODoQQeIUOuB5uGUJjRSTv
X-Received: by 2002:a4a:52c2:: with SMTP id d185mr4787882oob.8.1597327626802;
        Thu, 13 Aug 2020 07:07:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeiGfQxpCVrZBxl/IupXG+HiieUJGX1pf9TTQuoJCQy4jQixWt3yjdm0mI9ztVpuUj6EB1hgCns/RG7IOzMsk=
X-Received: by 2002:a4a:52c2:: with SMTP id d185mr4787847oob.8.1597327626508;
 Thu, 13 Aug 2020 07:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200813035509.739-1-jarod@redhat.com> <27389.1597296596@famine>
In-Reply-To: <27389.1597296596@famine>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Thu, 13 Aug 2020 10:06:56 -0400
Message-ID: <CAKfmpSeRsh4tYaQPg22d8L92i1jEP3J9Y5G8udutGruVURa=Fg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: show saner speed for broadcast mode
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 1:30 AM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >Broadcast mode bonds transmit a copy of all traffic simultaneously out of
> >all interfaces, so the "speed" of the bond isn't really the aggregate of
> >all interfaces, but rather, the speed of the lowest active interface.
>
>         Did you mean "slowest" here?

I think I was thinking "lowest speed", but the way it's written does
seem a little ambiguous, and slowest would fit better. I'll repost
with slowest.

> >Also, the type of the speed field is u32, not unsigned long, so adjust
> >that accordingly, as required to make min() function here without
> >complaining about mismatching types.
> >
> >Fixes: bb5b052f751b ("bond: add support to read speed and duplex via ethtool")
> >CC: Jay Vosburgh <j.vosburgh@gmail.com>
> >CC: Veaceslav Falico <vfalico@gmail.com>
> >CC: Andy Gospodarek <andy@greyhouse.net>
> >CC: "David S. Miller" <davem@davemloft.net>
> >CC: netdev@vger.kernel.org
> >Signed-off-by: Jarod Wilson <jarod@redhat.com>
>
>         Did you notice this by inspection, or did it come up in use
> somewhere?  I can't recall ever hearing of anyone using broadcast mode,
> so I'm curious if there is a use for it, but this change seems
> reasonable enough regardless.

Someone working on our virt management tools was working on something
displaying bonding speeds in the UI, and reached out, thinking the
reporting for broadcast mode was wrong. My response was similar: I
don't think I've ever actually used broadcast mode or heard of anyone
using it, but for that one person who does, sure, we can probably make
that adjustment. :)

-- 
Jarod Wilson
jarod@redhat.com

