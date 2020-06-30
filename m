Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056B920656
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8dsGP7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgF3VMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:12:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgF3VMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593551555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9eR1j7iPcbPhsuYnUXZuMKKFs2mdd8EpB3F1MmbQhjc=;
        b=M8dsGP7+x7NR/q4CAgxQBgT5RBAlK3NLHZoAbzZQFiI1quviXU0rWGGbPJEvilKx3FEG8P
        tFacBY6Zka6y7OgABFnQYUwSKSDf8l3M8i5MIsKhCs0ylONPPpeRIFskvE1dXqG2xjn42J
        D2e0+IY7sdDuJGezG0w593ci9U1bQ5I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-vFsMYuyaMrKOvuuBIA23qw-1; Tue, 30 Jun 2020 17:12:00 -0400
X-MC-Unique: vFsMYuyaMrKOvuuBIA23qw-1
Received: by mail-qk1-f198.google.com with SMTP id k16so2260203qkh.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9eR1j7iPcbPhsuYnUXZuMKKFs2mdd8EpB3F1MmbQhjc=;
        b=mX4WRfnAS717B2faFVFkIFIDXtUGWuc6OR6H0mK5TGlSb//kTdzAlJYONPbNbUn77Z
         CrYfBX41p0AB80HmlqjyXozYvqs5ksnJwVbsp/BndfWMGDuc5bCrSmbZQKUoNo0KimNq
         Ri9Ppqlc8+V0g4PukKijayhAN2X5JpDM2b3fbdvMBmgsjbObW5oVDmJpIbd3F8+vTI1D
         oUJ9xsy32mKCW6E2opPVNeihyfwWhVdOPZfOuEkCHfV6gzrFudWlAWeyVPQb7Hr+SxUa
         fup+/HXc69cjK4FTFRWK08WyXwFJ7Tpw3OUOShh+bw2MnLwzDzrLmVwXg79IPZaN7c1p
         Aeqg==
X-Gm-Message-State: AOAM533RQWjHnU5KwFY54N69ACLbEaKbGkWMIDUTi486mM9nxYtCtKOL
        MyHg4W7AQdTzLe8e2AeKqIEhQ9mHH1msuBzqVChNcAOhALOydW7+RGcZ3Gpx5NV1eifubC3X/yF
        qi3X/SsT8CuFpBMbVhXAJo+ks
X-Received: by 2002:a37:ec7:: with SMTP id 190mr21529983qko.49.1593551519957;
        Tue, 30 Jun 2020 14:11:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0oRW7HcfplpxcyTXsUSoBs7Ov1XtMthvXOXChOMssYR6yP7Q4ax0/y+vnmQ8nRbXAj97WgQ==
X-Received: by 2002:a37:ec7:: with SMTP id 190mr21529805qko.49.1593551517572;
        Tue, 30 Jun 2020 14:11:57 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u20sm4286037qtj.39.2020.06.30.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:11:56 -0700 (PDT)
Date:   Tue, 30 Jun 2020 17:11:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/26] mm: Page fault accounting cleanups
Message-ID: <20200630211155.GA40675@xz-x1>
References: <20200630204501.38468-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630204501.38468-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:45:01PM -0400, Peter Xu wrote:
> v4:
> - rebase to linux-next/akpm
> - picked one more r-b

I fixed some stuff in the send scripts but definitely broke something else on
the chaining of the messages.  Andrew, please let me know if you want me to
resend...  Sorry for that.

-- 
Peter Xu

