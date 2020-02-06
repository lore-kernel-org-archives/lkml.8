Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2814820730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBRy7ulQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBFL0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:26:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22968 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgBFL0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580988403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5piNXc1fMT29Zpv4Z7TyeSYOjlJ928bleKih104+/Vg=;
        b=UBRy7ulQ06UGkmM+jakhjLKna+KOi4UO3Olz0AT5rWGUfTUipfucm83GK5uZaruHqrVTJ0
        N53LinAgRSN6kL1MeHduSctPQ1oW1h+uCQ8mNcSXLcI2vhXQFr2hCZjb+h942k1wC9CWpc
        IAMXJjJO6qCvBD3tDBkrGa25r+U4wCU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-Vx9_9YUKPcKMYpoeYHZb1w-1; Thu, 06 Feb 2020 06:26:42 -0500
X-MC-Unique: Vx9_9YUKPcKMYpoeYHZb1w-1
Received: by mail-qt1-f197.google.com with SMTP id r9so3611436qtc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5piNXc1fMT29Zpv4Z7TyeSYOjlJ928bleKih104+/Vg=;
        b=YUc1S1V1mWf9rm6SoUwe/SI3/nP4A7Doiz32C49KiuufkgFyymXDBgny0JvNiEpjyw
         /4wmxR1Yl2mQl+c+vp1KGwZS4KgWyHo2ROQnX2XqzXWIDaKZhXeyCApBTLGYhglLGwQt
         r2GsQsHvlaCK0PH9zxDFYnYuqRLOEHSvPvQR67vOo9R7lHqo24cIv6D5huS7QXe2Iog+
         cdqDZwwxH29unrnnYG8Vb03mU+X8bn2dfgy6O97eT1px6ykMYZE0pOlR/cVargmZNfJH
         E5CSkicrTeEcXK/81tHHMt1gnAEsAGqt8KG36jV1dfnLvu2ddJGC9l4i+Pw8kJURMLd+
         fLdQ==
X-Gm-Message-State: APjAAAURMarFLBUyUjbAK1Fe3i9CMLzDZTdY2DmT2RDNUoOSE3qxOn1y
        ItZT43Gf79ZWR5YxRTDQIm/l1//QSBNUf71UNEgu+AoWGzb1F7maElj+x2s9ib/hNqTTRIWL6IT
        rPh9nEJvQ3Y5oElRvF1AT9HzQ
X-Received: by 2002:ad4:4434:: with SMTP id e20mr1838484qvt.157.1580988401904;
        Thu, 06 Feb 2020 03:26:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzs2H4Ue1BislOS6JG/nHk8GpbKHgxSbqwXwcwg9tcef/fex6WCKz5lI8ZaFpUYEjzL720t+A==
X-Received: by 2002:ad4:4434:: with SMTP id e20mr1838467qvt.157.1580988401685;
        Thu, 06 Feb 2020 03:26:41 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id b24sm1422245qto.71.2020.02.06.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:26:40 -0800 (PST)
Date:   Thu, 6 Feb 2020 06:26:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "tysand@google.com" <tysand@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "penguin-kernel@i-love.sakura.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Message-ID: <20200206062558-mutt-send-email-mst@kernel.org>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <20200206035749-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E4238A5@shsmsx102.ccr.corp.intel.com>
 <20200206042824-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E42395B@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73E42395B@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:43:10AM +0000, Wang, Wei W wrote:
> On Thursday, February 6, 2020 5:31 PM, Michael S. Tsirkin wrote:
> > 
> > How about just making this a last resort thing to be compatible with existing
> > hypervisors? if someone wants to change behaviour that really should use a
> > feature bit ...
> 
> Yeah, sounds good to me to control via feature bits.
> 
> Best,
> Wei

To clarify, shrinker use could be a feature bit. OOM behaviour was
there for years and has been used to dynamically size guests.

-- 
MST

