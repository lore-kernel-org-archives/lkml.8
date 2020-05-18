Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E898C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A74920657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMXdM/Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgERWPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:15:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgERWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589840138;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=prsCkCxLy7bTtHoNJZEl6S+IBLY3Vu826GUD9uYHGiY=;
        b=GMXdM/Zyw4VueoKJVOtQK8OAUpNChoOfVS5QTjDFh4uHb4zo6JI4xfJizVSJu1bNoTs206
        8txUBQw1Jy8GdgRWfw4uXFjS+mYolWDdWAqOn6iGz1tVgplF43AejxwtVGWyTi6+p6ycni
        RY4L/k8PIlt/qfsYRqCFB6HtWtTRuKs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-D5YhnMb-NvmR81rG7cJ_pQ-1; Mon, 18 May 2020 18:15:37 -0400
X-MC-Unique: D5YhnMb-NvmR81rG7cJ_pQ-1
Received: by mail-qk1-f199.google.com with SMTP id r124so12335359qkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=prsCkCxLy7bTtHoNJZEl6S+IBLY3Vu826GUD9uYHGiY=;
        b=LGak06+MEDxq5Ln9BYN3+7a5Fp+U0rlFeX251hh7i4KYZ8ty2E08Kmr41iffuYKhsN
         sQBqaCCNu9ryTElyf6uMzYgTCK9l5Nd/ihRrPJfO5nPWLb+y/hWQXgBqrO6sPUfDm3bE
         v2Ba9djewvufkOjrPoW0sv3snzdZ3n21+PIsFvmNfIzc/b3zJxCDgxWWK81grGHxyeV9
         KNGX74n04V8QrXd8phrlPop33uhXZ+Obt7geKeFP9Cghbnm5cU2Ynizvar5AlfVv5uBk
         wgN/z7ev2Yn5EP17OSZ2xGflJzqHuVQLO26mhZkZqQK21NZMqxq1OIgHCZgFh5NkBgb+
         drMw==
X-Gm-Message-State: AOAM533mnz50zXsMBtLt1XlKr0qwckjv0O/EcwZIuN6urK5JGrz676n0
        6+1C+6DVEnU14l+lrbdQEvKI4CYemfqs0X7O62WcG5fYnQ1uNIpAh1NY4/AwRVvu0AnR1Lt24Lr
        tfbuYNhu7IXvrW1G1kQT1L4ia
X-Received: by 2002:ac8:34a2:: with SMTP id w31mr19243746qtb.368.1589840136566;
        Mon, 18 May 2020 15:15:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztGJSlm+3MgWXGvF/R/sy62O7hJQ1szJo28kqLWu4sfGu/yMbfNJHY/6iPOkZmIF4l2XweMg==
X-Received: by 2002:ac8:34a2:: with SMTP id w31mr19243709qtb.368.1589840136227;
        Mon, 18 May 2020 15:15:36 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n206sm9251212qke.20.2020.05.18.15.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:15:33 -0700 (PDT)
Date:   Mon, 18 May 2020 15:15:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200518221531.5mddl4fatu5hvbyb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
 <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
 <20200518132656.GL8135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200518132656.GL8135@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon May 18 20, Joerg Roedel wrote:
>On Fri, May 15, 2020 at 08:23:13PM +0100, Robin Murphy wrote:
>> But that's not what this is; this is (supposed to be) the exact same "don't
>> actually perform the attach yet" logic as before, just restricting it to
>> default domains in the one place that it actually needs to be, so as not to
>> fundamentally bugger up iommu_attach_device() in a way that prevents it from
>> working as expected at the correct point later.
>
>You are right, that is better. I tested it and it seems to work. Updated
>diff attached, with a minor cleanup included. Mind sending it as a
>proper patch I can send upstream?
>
>Thanks,
>
>	Joerg
>

I should have this tested this afternoon.

