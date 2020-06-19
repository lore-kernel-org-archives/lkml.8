Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D067AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0247217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo27wGEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394571AbgFSQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:18:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35138 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389837AbgFSQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ngyh6J+8wDJPZSODVYPs3G1iyY37jNk7aoNr2X++1Ow=;
        b=eo27wGEBPvXHCwXA6Wwp/66yIbadWg/d99bG0k8Ei5P5CEPcyFDw3F/VHC3rqeHjeaeTgs
        jjiQfD8j5Vz4QHywpyZ53soarnzhKcgTepqyBTXOhc6gn9lRNv1NKDHkVg5U99eCrJLdKi
        Ocwpr5BxKP+yoEt3DvYgi2MJZ/MBs30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-shztnlz2M2WGseoUld65Iw-1; Fri, 19 Jun 2020 12:18:18 -0400
X-MC-Unique: shztnlz2M2WGseoUld65Iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2C0A107ACCA;
        Fri, 19 Jun 2020 16:18:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7C4709D7;
        Fri, 19 Jun 2020 16:18:14 +0000 (UTC)
Date:   Fri, 19 Jun 2020 12:18:14 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH 21/29] docs: device-mapper: add dm-ebs.rst to an index
 file
Message-ID: <20200619161813.GA24642@redhat.com>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <e6195a56b6e7924ccbb7fd07837453530f02e9dc.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6195a56b6e7924ccbb7fd07837453530f02e9dc.1592203542.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15 2020 at  2:47am -0400,
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Solves this Sphinx warning:
> 	Documentation/admin-guide/device-mapper/dm-ebs.rst: WARNING: document isn't included in any toctree
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/device-mapper/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
> index ec62fcc8eece..6cf8adc86fa8 100644
> --- a/Documentation/admin-guide/device-mapper/index.rst
> +++ b/Documentation/admin-guide/device-mapper/index.rst
> @@ -11,6 +11,7 @@ Device Mapper
>      dm-clone
>      dm-crypt
>      dm-dust
> +    dm-ebs
>      dm-flakey
>      dm-init
>      dm-integrity
> -- 
> 2.26.2
> 

Didn't see this fix staged in linux-next so I've picked it up for 5.8.

Thanks,
Mike

