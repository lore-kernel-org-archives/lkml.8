Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B9C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD0A20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pC+JllgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCMNxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:53:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38312 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgCMNxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:53:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id e20so7511960qto.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhTAEUb0CKU7cUmJxlGIQXm3jXmhdS/EU6RvOkuimUc=;
        b=pC+JllgYSu5r6kQR54aaqYTMDt6E7+AP+ncEtV8/YJ7mtqAZ/2/JYJ/wDnhHDRcsL6
         wGq6H8l+r6u7GBB/45/+tQudBCb9mu78Avehje7/VxZi4jxYZfF81mhLMeT/vArq3S7p
         c0yFXsamH0g2jmyGiOq1jVRlozRFMuNOs/NPhv0i4XVpoGWWb3gyPcBgIiW3Ib6T+VCW
         /0Gl8bTAOzm/JqFK4BGGMEOctYH9YKTlLUXdlRYVt/vfTj/Fqh6IabQZfdZBjqHlwS0r
         jj5DXo9RjV8u0QTPnxbmB7gfSro/CIIAXgPqOBMtta9EsCrid91JuPTnGP9jCuOY6qfk
         kF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhTAEUb0CKU7cUmJxlGIQXm3jXmhdS/EU6RvOkuimUc=;
        b=o53ykfHt2IghHa0AQbyw+dlYGQelxmWSePoO+eqFZ7ALYQ0M07+sPHkEVORJbmLd6d
         56/OJ8pkBLdNTRRJHrXxpwarIyHK31Ik5AlYY43foW8LurHCHWic63t8RzAknpMXvnvB
         UVzXMUPdbRc++8FbEWCqhrlnkrfevmN3qzZOu1Q7USLELtSA/IReax+uj0nOEiki0GvJ
         Jah+l7irwDTE0wbWIZxZYZuQGxuYkp944SOWIxJvKLO/UNViA2tGFaVKjjQmx0++hNgT
         NZbC1QHHT3JLyWDg0UOxVbcs/s0qDm/rreIHI5kOfpCPp+/56+Yq6g4rHvtTgGBnChNS
         e4xA==
X-Gm-Message-State: ANhLgQ0jER0+sZmvMWcxOs71hcAkZYjj/Q5VRbXXlvXdLtBGDwts8ix0
        79af67OC7ORkm5/ti5d8uhYWMw==
X-Google-Smtp-Source: ADFU+vtU2B6nwFziiJDBl9BQ05KoFsPk7oHkeEWfg9BnU1sdLDW+4Hmsyy4Ve0AZoOIF5eZX7mrJGg==
X-Received: by 2002:ac8:7b2f:: with SMTP id l15mr12116784qtu.320.1584107584469;
        Fri, 13 Mar 2020 06:53:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x6sm9609039qke.43.2020.03.13.06.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:53:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkkJ-0006cr-Bd; Fri, 13 Mar 2020 10:53:03 -0300
Date:   Fri, 13 Mar 2020 10:53:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/11] Add Enhanced Connection Established
 (ECE)
Message-ID: <20200313135303.GA25305@ziepe.ca>
References: <20200310091438.248429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:14:27AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v1: Dropped field_avail patch in favor of mass conversion to use function
>      which already exists in the kernel code.
>  v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org
> 
> Enhanced Connection Established or ECE is new negotiation scheme
> introduced in IBTA v1.4 to exchange extra information about nodes
> capabilities and later negotiate them at the connection establishment
> phase.
> 
> The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
> to carry two fields, one new and another gained new functionality:
>  * VendorID is a new field that indicates that common subset of vendor
>    option bits are supported as indicated by that VendorID.
>  * AttributeModifier already exists, but overloaded to indicate which
>    vendor options are supported by this VendorID.
> 
> This is kernel part of such functionality which is responsible to get data
> from librdmacm and properly create and handle RDMA-CM messages.
> 
> Thanks
> 
> Leon Romanovsky (11):
>   RDMA/mlx4: Delete duplicated offsetofend implementation
>   RDMA/mlx5: Use offsetofend() instead of duplicated variant
>   RDMA/cm: Delete not implemented CM peer to peer communication

These ones applied to for-next

>   RDMA/efa: Use in-kernel offsetofend() to check field availability

This needs resending

>   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
>   RDMA/uapi: Add ECE definitions to UCMA
>   RDMA/ucma: Extend ucma_connect to receive ECE parameters
>   RDMA/ucma: Deliver ECE parameters through UCMA events
>   RDMA/cm: Send and receive ECE parameter over the wire
>   RDMA/cma: Connect ECE to rdma_accept
>   RDMA/cma: Provide ECE reject reason

These need userspace to not be RFC

Jason
