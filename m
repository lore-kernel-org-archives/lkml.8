Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6877FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6F2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6EOA7Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgDBBqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:46:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726319AbgDBBqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585791967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGKV+mj5X3vQFrVkT1HrrdE3Djy0V822MxL90EGqQw8=;
        b=W6EOA7PzcL8QmIna9pKOpBqx4NFm5EC08exkqMzS5rCh8z98aWlXdROpzHtfjdv2aEXZFS
        5cPESMP01fDQq4J+T3grshBBr67YUE16ZHR1fve+rvJ8lkGPn7PqA4BurL+Cg4TRKullqx
        OEWyk6CtDzADXiFd4SrrVWeYeSbVB5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-bZQTtJhKNEOBPbHDx9O6Bw-1; Wed, 01 Apr 2020 21:46:06 -0400
X-MC-Unique: bZQTtJhKNEOBPbHDx9O6Bw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D18DE107ACC7;
        Thu,  2 Apr 2020 01:46:03 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 949749A240;
        Thu,  2 Apr 2020 01:45:56 +0000 (UTC)
Date:   Thu, 2 Apr 2020 03:45:51 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: android: ion: Fix
 parenthesis alignment
Message-ID: <20200402034551.1775a192@elisabeth>
In-Reply-To: <20200402012515.429329-1-jbwyatt4@gmail.com>
References: <20200402012515.429329-1-jbwyatt4@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Apr 2020 18:25:15 -0700
"John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:

> Fix 2 parenthesis alignment issues.
> 
> Reported by checkpatch.
> 
> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

