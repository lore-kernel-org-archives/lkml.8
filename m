Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8231C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099020882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579609819;
	bh=7zVSCo4bHkZ8rsiPtQ9fANUwzfp54VRfaomswFoeaTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W88P0PfY7dmQqFojPqXj+W2GVHqIU4ttKULzI3j5Wf7Yeex4Ymgpu9Kn3lfMtOJWh
	 rStaPe1KV5RkOOWBejzSEbZm1bR/d4RmfcVqCyjpaJlpPM14EJ9paBgHDJ99UF9KST
	 nnX3yK+m2rONkmfhfUpvZP5/1/GKePQBmGmAnHFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgAUMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:30:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56264 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgAUMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:30:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so2752434wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jANiQwDgpGHM04JQ+o8U8xuaAXHe7Za6seI5Varxfk=;
        b=O3gtok8NI5RmT1Z+MgIen6BN0PCuJ+ze1Qu9XSeW52HB/RcimMxMiRM7hU+hrG0Ymb
         R1nLMyVbmurdzu7RdAjARX1CqeINQe0yWL3hH+JqvvEg2flNqK9J98atq4HQcxe0OzFS
         6h5hkQ6yc013tjAkzGfu/YE87dfNRfgF+Z6ZK3ZwgXxlrxlMBY2xcsT1/oitH042djc7
         MEopp6opD+QrTWVoUiXyt6tiuBTo/sjOi/zWCmvpry8apDRd02XdH9jbYAbstkghDyMP
         eIicK13trjcot91z+0MOsZ98LGHfDk8a6+coLKObXM0sRoS5agsnJHDPZxxAS+nBx5HK
         WXKw==
X-Gm-Message-State: APjAAAXaWFbLKjV0SX4F3NS0WuEqGK2WTwTlcw7ijLK7M0bk1EdAS01P
        oeXleDKBh9n7v2BWMyjJffY=
X-Google-Smtp-Source: APXvYqwcgA5nH5ammvhK9QPI3vKZPJ/FB3PT9taDyX6TYfo+yLOQMxpMVDw/ptedKlkvAhF5z+yl/Q==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr4140274wmg.139.1579609815924;
        Tue, 21 Jan 2020 04:30:15 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i5sm53094340wrv.34.2020.01.21.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:30:15 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:30:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200121123014.GK29276@dhcp22.suse.cz>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
 <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
 <181caae3-ffb8-c745-a4c9-1aef93ea6dd5@redhat.com>
 <20200116152214.GX19428@dhcp22.suse.cz>
 <765a07fe-47e9-fe3d-716a-44d9ee4a5e99@redhat.com>
 <fe92b4f0-0cd7-c705-1ed9-239175689051@redhat.com>
 <20200117093514.GO19428@dhcp22.suse.cz>
 <2df18523-e410-bcfb-478e-6a7579608196@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df18523-e410-bcfb-478e-6a7579608196@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 10:15:32, David Hildenbrand wrote:
[...]
> Ping Scott. Will you resend a cleanup like this as a proper patch or
> shall I?

Maybe just fold it into the orignal patch which is already sitting in
mmotm?
-- 
Michal Hocko
SUSE Labs
