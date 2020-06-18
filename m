Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7510BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41871208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOazMu6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgFRRKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727822AbgFRRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592500202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EyHPYI/UjAp3H72S5spcJb48+H24FYKREDj4k4PySN8=;
        b=AOazMu6Kmu3WOrgQ/haewEV730YZT23PJf3F53pwj0DB86svNQr6WVw1Mex4B2PaTuwdec
        uVBap9S7a5RuGGEDGinFRUbiAwtD6aLW3cy2GINV7Tz3yLSH2aKwdh+CxD2VLFuNGq+yo4
        J9dJ6+YG0ux8xeqc9j7W86SPK1Mq8iI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-xiDt_yXBOaCnju_C80WpYw-1; Thu, 18 Jun 2020 13:10:00 -0400
X-MC-Unique: xiDt_yXBOaCnju_C80WpYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C7CE107ACCD;
        Thu, 18 Jun 2020 17:09:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65EEB5D9E5;
        Thu, 18 Jun 2020 17:09:53 +0000 (UTC)
Date:   Thu, 18 Jun 2020 13:09:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     JeongHyeon Lee <jhs2.lee@samsung.com>, dm-devel@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        agk@redhat.com, corbet@lwn.net
Subject: Re: New mode DM-Verity error handling
Message-ID: <20200618170952.GA18057@redhat.com>
References: <CGME20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25@epcas1p4.samsung.com>
 <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
 <20200618154444.GB18007@redhat.com>
 <20200618165006.GA103290@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618165006.GA103290@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18 2020 at 12:50pm -0400,
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Thu, Jun 18, 2020 at 11:44:45AM -0400, Mike Snitzer wrote:
> > I do not accept that panicing the system because of verity failure is
> > reasonable.
> > 
> > In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.
> > 
> > The device should be put in a failed state and left for admin recovery.
> 
> That's exactly how the restart mode works on some Android devices. The
> bootloader sees the verification error and puts the device in recovery
> mode. Using the restart mode on systems without firmware support won't
> make sense, obviously.

OK, so I need further justification from Samsung why they are asking for
this panic mode.

Thanks,
Mike

