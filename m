Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06145C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E512053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+9xfNqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgFHQwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:52:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730637AbgFHQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591635136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPoX45gxmjOqLoIv20XcIEcYRq/YssF2EgI5KSAc3xY=;
        b=S+9xfNqN5EnFMcA5DYY9SpPWlHudUByG/QWwg+oGIaNbTmDWAPJCRTZHxJlKeHrHXG7WHY
        h5STjA26XJSzXKCoLYnP8XxszSVjn7dMqiViS0d/IY5XxspQJADJ7tv7tjA1fRIGKcoOX+
        k6vpEmWChOo2qKgi805jQAkIEz4z8/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-svhNfv0uPqysAzmo1_b8Nw-1; Mon, 08 Jun 2020 12:52:10 -0400
X-MC-Unique: svhNfv0uPqysAzmo1_b8Nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F4EB8014D4;
        Mon,  8 Jun 2020 16:52:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11E88648DB;
        Mon,  8 Jun 2020 16:52:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87ftb6x7em.fsf@intel.com>
References: <87ftb6x7em.fsf@intel.com> <2136072.1591491984@warthog.procyon.org.uk> <87o8puxak1.fsf@intel.com> <4ff2445aff8d44c5961a6d194a8f4663@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dhowells@redhat.com, "Saarinen\, Jani" <jani.saarinen@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied\@redhat.com" <airlied@redhat.com>
Subject: Re: [Intel-gfx] A panic and a hang in the i915 drm driver
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2715544.1591635126.1@warthog.procyon.org.uk>
Date:   Mon, 08 Jun 2020 17:52:06 +0100
Message-ID: <2715545.1591635126@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Nikula <jani.nikula@linux.intel.com> wrote:

> David, please try [1].

Assuming you mean this:

    https://patchwork.freedesktop.org/patch/366958/?series=77635&rev=1

yes, that works.

Tested-by: David Howells <dhowells@redhat.com>

