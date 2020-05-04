Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C68DC28CBC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 02:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3E32071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 02:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gg3GExlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgEDCgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 22:36:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbgEDCgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 22:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588559813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyYrNtyd0qNR/27bbC3vw4qOpKynz0aNHsHz7AO+7T8=;
        b=gg3GExlDiq9dFfXZnITPpuyAh69H8CtkbFFamLCbn1xKDTjn9pAQOcUIahPZ2dOswepOpZ
        GD2rOLQuL06g8B5AHubh7xN5rM1NcjOrZJTB9bItNpDkRRQkoUhL/TiR+Yl+dNqHXrKa+H
        JvDuYOXW0XN/E/mzYNGPS8MeJrTWbQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-53dzPPjXM1Sc3xJjWpXY4w-1; Sun, 03 May 2020 22:36:49 -0400
X-MC-Unique: 53dzPPjXM1Sc3xJjWpXY4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F03A1005510;
        Mon,  4 May 2020 02:36:47 +0000 (UTC)
Received: from t490s (ovpn-112-64.phx2.redhat.com [10.3.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE8F1002382;
        Mon,  4 May 2020 02:36:45 +0000 (UTC)
Date:   Sun, 3 May 2020 22:36:43 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
Message-ID: <20200504023643.GA18463@t490s>
References: <20200501215441.GE27720@optiplex-lnx>
 <8CD9EA82-8BE1-47B4-AD35-7D300CAD745C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8CD9EA82-8BE1-47B4-AD35-7D300CAD745C@lca.pw>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 07:17:24PM -0400, Qian Cai wrote:
>=20
>=20
> > On May 1, 2020, at 5:54 PM, Rafael Aquini <aquini@redhat.com> wrote:
> >=20
> > It seems like a good idea which also would required "adding things"
> > elsewhere, but doesn't look mutually exclusive with the approach here=
.
>=20
> Also, what=E2=80=99s so special about these bad pages here that deserve=
 a crash dump, but not other TAINT_BAD_PAGE places?
>

In that light, yes they're not as different and we could better leverage
a panic_on_taint mechanism (similar to panic_on_warn).

I'll get that posted soon.

Thanks.
-- Rafael=20

