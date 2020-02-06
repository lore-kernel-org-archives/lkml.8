Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BFC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34655206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB75OWtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBFJJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:09:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29071 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgBFJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580980185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1LG9DblC2cTdhxgTIVXCEtFlpZae6akT23NYT3sY/o=;
        b=BB75OWtBDQSJ3x2VHUOK6ysM+fPp5SMXsyTb5MR5CMfu5jNRXHNRp0D/EoGwkIE8I5VNKK
        sqppzFfnK43nU1lY8OUNyn6ZVQYds/J+yCy6C+ag1WEkvksOyHQCv/WOCoxyWQmT7o5rdH
        ctrT/ByhmWyH0AABFvboLR2ksEpUV+A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-4I8cYXz4M0K8Hxy9lF4N4A-1; Thu, 06 Feb 2020 04:09:44 -0500
X-MC-Unique: 4I8cYXz4M0K8Hxy9lF4N4A-1
Received: by mail-qk1-f198.google.com with SMTP id a23so250958qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 01:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1LG9DblC2cTdhxgTIVXCEtFlpZae6akT23NYT3sY/o=;
        b=uDVdWcHdE2hvWMrqm4ykRvUClnmxPyCtJNyy9/MPaM5HLpL7HtDFOnNvYDy6ATtXKm
         ncWvDAWa8Qo0N7Lm6yrs7fZ82EPtM4CPmKIG4miGoWajP1QZY5X4Zx8JXmZxvSi8QJjo
         ckjzvB9nX/zzXfaLAAZBP1svo4EYTu0PUFJa2Lh/mbPXKcNl+PvGY/Fb+cXDOjtBaOUC
         vwmg3pw4GIp/6+v9JcleRIcidaD4rpBLYmEBsPSHig4Bzta/bCJJG9gWue+ngralPOic
         H5ILstFk4D4DYyzd9Xokcmc4xVxuSXjlQL8NNhznUt+jvE/lcAm5tbrIMKrXARuOBtFV
         7q/g==
X-Gm-Message-State: APjAAAVPniUeM6S/6Jpqx2yuSEol8rYT/fyHDYqeXpdiGYc+bUuDJMJb
        TcJxIr2GtchZq0gd0OEyJjd/jXED1e8nR8GklE3WpsdV4KDi0zoxWidh7Y2BOhglh3XpHB9xhW2
        SS0f83UuyEL4u4fQuvcVT7CWI
X-Received: by 2002:a05:620a:ced:: with SMTP id c13mr1563611qkj.47.1580980183669;
        Thu, 06 Feb 2020 01:09:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfMTZ5Cg+M33ciqGE043zi3UGdLoIZDBLsziU6lg7yBA1llshc6iEL8HwIf8KHgdth7yTgAA==
X-Received: by 2002:a05:620a:ced:: with SMTP id c13mr1563598qkj.47.1580980183446;
        Thu, 06 Feb 2020 01:09:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id y27sm1418057qta.50.2020.02.06.01.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 01:09:42 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:09:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200206040927-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200206013724-mutt-send-email-mst@kernel.org>
 <51955928-5a4b-c922-ee34-6e94b6cdd385@redhat.com>
 <20200206034916-mutt-send-email-mst@kernel.org>
 <a5dc8a7c-7384-5efa-e251-1cd9a240e73a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5dc8a7c-7384-5efa-e251-1cd9a240e73a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:05:43AM +0100, David Hildenbrand wrote:
> >> commit bf50e69f63d21091e525185c3ae761412be0ba72
> >> Author: Dave Hansen <dave@linux.vnet.ibm.com>
> >> Date:   Thu Apr 7 10:43:25 2011 -0700
> >>
> >>     virtio balloon: kill tell-host-first logic
> >>
> >>     The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
> >>     feature bit.  Whenever the bit is set, the guest kernel must
> >>     always tell the host before we free pages back to the allocator.
> >>     Without this feature, we might free a page (and have another
> >>     user touch it) while the hypervisor is unprepared for it.
> >>
> >>     But, if the bit is _not_ set, we are under no obligation to
> >>     reverse the order; we're under no obligation to do _anything_.
> >>     As of now, qemu-kvm defines the bit, but doesn't set it.
> > 
> > Well this is not what the spec says in the end.
> 
> I didn't check the spec, maybe I should do that :)
> 
> > To continue that commit message:
> > 
> >     This patch makes the "tell host first" logic the only case.  This
> >     should make everybody happy, and reduce the amount of untested or
> >     untestable code in the kernel.
> 
> Yeah, but this comment explains that the current deflate is only in
> place, because it makes the code simpler (to support both cases). Of
> course, doing the deflate might result in performance improvements.
> (e.g., MADV_WILLNEED)
> 
> > 
> > you can try proposing the change to the virtio TC, see what do others
> > think.
> 
> We can just drop the comment from this patch for now. The tell_host host
> not be an issue AFAIKS.

I guess it's a good idea.


> -- 
> Thanks,
> 
> David / dhildenb

