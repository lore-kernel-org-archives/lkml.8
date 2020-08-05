Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CB82177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7UuepLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHEIKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:10:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728068AbgHEIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596614996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35YQLrzEFpSuMDBiIDVfflKea5B3kUFbcPPBSXZZfAA=;
        b=i7UuepLwC0Sxn/AoSTzLpe4no2O+DY/qFssOvffVXq82QTVNsOV0u53t+3zn2aBRizJicO
        yZeI1Zu+DsmDh64jAaJoDjJtmwqCqukp59P1KpdFctNcSLjiupeLBEVxq0jOQeqCLsVVyo
        ESFdeouZNTrlknSIt9q26O1aJi3QnRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-jIFZ95raOXGXS3EdU61sUA-1; Wed, 05 Aug 2020 04:09:52 -0400
X-MC-Unique: jIFZ95raOXGXS3EdU61sUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 249CC100A8FD;
        Wed,  5 Aug 2020 08:09:51 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F44088D57;
        Wed,  5 Aug 2020 08:09:45 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 12/12] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804162048.22587-13-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2e243137-5ada-1161-ed27-62804f24752b@redhat.com>
Date:   Wed, 5 Aug 2020 16:09:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804162048.22587-13-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 上午12:20, Eli Cohen wrote:
> Add a front end VDPA driver that registers in the VDPA bus and provides
> networking to a guest. The VDPA driver creates the necessary resources
> on the VF it is driving such that data path will be offloaded.
>
> Notifications are being communicated through the driver.
>
> Currently, only VFs are supported. In subsequent patches we will have
> devlink support to control which VF is used for VDPA and which function
> is used for regular networking.
>
> Reviewed-by: Parav Pandit<parav@mellanox.com>
> Signed-off-by: Eli Cohen<eli@mellanox.com>
> ---


Acked-by: Jason Wang <jasowang@redhat.com>


