Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000E7206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQiDJfsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCMOfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34181 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgCMOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584110134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WezdpOlVzbaVEs6vfCIvevGk8ide+y5ytNMFt7/McDI=;
        b=OQiDJfsMfXrisXCbzA7Q1mFgNbAFWXWvNRTj8BnzXR/oL7J9TuLlFT9B6oN0PsnaoJNLG5
        uDe+wMKHRINU+S4BTeRHTlT10gzwhnbRlvJV+3xyPxiuZ3ZRp8P65HsF7mvL6MjIimRhmM
        LSqyT7AbFULDGjHHllaABjgy3AJqKPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-2q7-IqrANO65NjR6AP5ocw-1; Fri, 13 Mar 2020 10:35:33 -0400
X-MC-Unique: 2q7-IqrANO65NjR6AP5ocw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF02E1005509;
        Fri, 13 Mar 2020 14:35:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 225AF907F7;
        Fri, 13 Mar 2020 14:35:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1C1A29DB3; Fri, 13 Mar 2020 15:35:30 +0100 (CET)
Date:   Fri, 13 Mar 2020 15:35:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Message-ID: <20200313143530.6aoagldak3kpe3xv@sirius.home.kraxel.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
 <20200313090338.GA31815@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313090338.GA31815@ravnborg.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> > +		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
> So you could use drm_WARN() which is what is preferred these days.

Nope, this isn't yet in -fixes.

cheers,
  Gerd

