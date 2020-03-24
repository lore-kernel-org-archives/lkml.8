Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B838AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rms3BA68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCXUDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:03:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47976 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbgCXUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585080217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFnWzCsyUtuGFlv+OdaYqRCE9oNOsfSnbr0kqIOCDpA=;
        b=Rms3BA680K9bcFnnABptC2/d+m3In3enPBR4/17FT0xzF+VIKg+vuwzkzA7dLisZgQgzhh
        ZyUYdMfKfGPJs8c8CldGfrmv+RT6KZp56o42OtwZLE4x3MzvSJo+9l3aNHOpcAvm6ogzwI
        XEAhSKVKOWKhvCSTPYrrO8zfNua+gMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-2r8vi0L4NjeVcxTZF8KFdQ-1; Tue, 24 Mar 2020 16:03:33 -0400
X-MC-Unique: 2r8vi0L4NjeVcxTZF8KFdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBCE08017CC;
        Tue, 24 Mar 2020 20:03:31 +0000 (UTC)
Received: from new-host-5 (unknown [10.40.194.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFC795DA7B;
        Tue, 24 Mar 2020 20:03:29 +0000 (UTC)
Message-ID: <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] driver core: Skip unnecessary work when device
 doesn't have sync_state()
From:   Davide Caratti <dcaratti@redhat.com>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Benes <vbenes@redhat.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200221080510.197337-4-saravanak@google.com>
References: <20200221080510.197337-1-saravanak@google.com>
         <20200221080510.197337-4-saravanak@google.com>
Organization: red hat
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 24 Mar 2020 21:03:28 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-21 at 00:05 -0800, Saravana Kannan wrote:
> A bunch of busy work is done for devices that don't have sync_state()
> support. Stop doing the busy work.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

hello Greg,

this patch and patch 2/3 of the same series proved to fix systematic
crashes (NULL pointer dereference in device_links_flush_sync_list() while
loading mac80211_hwsim.ko, see [1]) on Fedora 31, that are triggered by
NetworkManager-ci [2]. May I ask to queue these two patches for the next
5.5 stable?

thank you in advance (and thanks to Vladimir for reporting)!

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1816765
[2] https://github.com/NetworkManager/NetworkManager-ci
 
-- 
davide  


