Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574A522CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/Odx8Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgHEUBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:01:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgHEQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596645679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvvVbA3neuStjhovJpqPYB6dYLf6War6ZdtpyVOVpoo=;
        b=i/Odx8Me+EPwmNQysiDcGj42l+I4M2lX/hXOnHR4ejUjdhvBL0d0xd609gRo6T0kvR0uPM
        ErHFxwGXLUcE+CewdQq5szRNp4SeGBvW+l8kiQJreBZ9WCBhAZaGp1MCYhbT3hsBtQe75z
        B5khOsvWa7NM+AAoBHOWjn0KMDX0Sg0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-HfoEEMGyOMSIrZeaPznJcg-1; Wed, 05 Aug 2020 09:13:03 -0400
X-MC-Unique: HfoEEMGyOMSIrZeaPznJcg-1
Received: by mail-wr1-f69.google.com with SMTP id b8so3952959wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvvVbA3neuStjhovJpqPYB6dYLf6War6ZdtpyVOVpoo=;
        b=RV6mf5RGV6gczLV6O2gZetSpZKdiIK0tZ19QsHxqz/seo1+VIhLrZjeCiTYuoWNhpQ
         MEUf2fg6RvoJ0/atR/3fY5sAD8p/HZ0V8/BaRX3JIMRqvSgsq8reWv+81+gZTIPwj/va
         Uhd2Yy9URkfTfiSMaJAAE8n5BbGqKTjrwwwZJTkkpdDgvc+5Bha+RnYQFYG8FWO2itqW
         LOxobWp/azb8O6mgIgvEpT2ZUI6rFDl38UukW/Bu7d8Khyas7iJOAt1sC502UGY3CTwR
         CdM+Egkkj63mQPAXgSCFlBLj8cMGv16/QYqZGLdUrERMRTmp5Rq3sdQKoNJOq8+dFIlG
         eZ2g==
X-Gm-Message-State: AOAM530VxfYllx7XwjC1ou84/i9c+OPvj/FwiVl5hCbQgtsqxG/SAbG6
        EiyQjdzpyit6WuodkVSXvgSC5BSy0ALQ6uVqqrG+voCHynGY3WmY3Vxq6Mu/WrLO2LVhDYT0X04
        MFOwUVgrI+sDlXiYiKubr5LzW
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr3411890wmd.144.1596633182190;
        Wed, 05 Aug 2020 06:13:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9coyERUcXT3yxN24ZYMf+XfyA2+T1qmyE4JuGsj7TRNRDbULVwH+0UMH6Eic7iEdmMl0Cjg==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr3411871wmd.144.1596633182015;
        Wed, 05 Aug 2020 06:13:02 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id 31sm2746951wrp.87.2020.08.05.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:13:01 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:12:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805090304-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
 <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 04:01:58PM +0300, Eli Cohen wrote:
> On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > Did you merge this?:
> > > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next
> > 
> > 
> > I can only merge this tree if no one else will. Linus does not like
> > getting same patches through two trees.
> > 
> > Is this the case? Is mlx5-next going to be merged through
> > my tree in this cycle?
> > 
> 
> Saeed Mahameed from Mellanox (located in California) usuaally sends out
> net patches. So he's supposed to send that to Dave Miller.
> 
> I think Saeed should answer this. Let's wait a few more hours till he
> wakes up.

Alternatives:
- merge vdpa through Saeed's tree. I can ack that, we'll need to
  resolve any conflicts by merging the two trees and show the
  result to Linus so he can resolve the merge in the same way.
- extract just the necessary patches that are needed for vdpa and
  merge through my tree.
- if Saeed sends his pull today, it's likely it will be merged
  early next week. Then I can rebase and send a pull with your patches
  on top. A bit risky.
- do some tricks with build. E.g. disable build of your code,
  and enable in Saeed's tree when everything is merged together.
  Can be somewhat hard.

