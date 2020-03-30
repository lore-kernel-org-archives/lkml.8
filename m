Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E5BC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2143720776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QELm2Snu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgC3GsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:48:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56602 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728964AbgC3GsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585550885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyfUsO/T0E/7xzoexsaycHqsJ0KjG21nQpinw4BcqNI=;
        b=QELm2SnuO61IbHdsql4RZvR7dvtdBzscGLNtyZje428ahc0O6LQY+tlRH9bUf3xfd7YJI1
        7PHDzk14La1+LfUKqnGohyZu0W3jT5jr79lD+v+SVEeAEKAAmfmHLHCEE/Aj3G13MWHRTq
        cflQM/ud7ccSs1BTq9HI15IPQKXHTjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-oot0cUrMMpKseoO5axt2Pg-1; Mon, 30 Mar 2020 02:48:01 -0400
X-MC-Unique: oot0cUrMMpKseoO5axt2Pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05523102CE14;
        Mon, 30 Mar 2020 06:48:00 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAC7B5E009;
        Mon, 30 Mar 2020 06:47:57 +0000 (UTC)
Date:   Mon, 30 Mar 2020 08:47:52 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Simran Singhal <singhalsimran0@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: rtw_cmd:
 Compress lines for immediate return
Message-ID: <20200330084752.7a0557ca@elisabeth>
In-Reply-To: <20200325212253.GA8175@simran-Inspiron-5558>
References: <20200325212253.GA8175@simran-Inspiron-5558>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 02:52:53 +0530
Simran Singhal <singhalsimran0@gmail.com> wrote:

> Compress two lines into a single line if immediate return statement is found.
> It also removes variable cmd_obj as it is no longer needed.
> 
> It is done using script Coccinelle.

This should be consistent. What does "it" refer to, now? If you start
with an imperative mode, switching to indicative makes it hard to
follow.

By the way, Coccinelle is not exactly a script. Saying something is
detected by Coccinelle is enough, you don't need to qualify that
further.

-- 
Stefano

