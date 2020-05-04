Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26707C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B052068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il15kmNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgEDSzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:55:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbgEDSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588618535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cx2x2osOhFhdNBb63MzyccRaN5HnojRzjf9rZPXLgjY=;
        b=il15kmNf2JXXBji6ys7hoTmu6yI6ds4OEcIhsTIdXLMk95y53hBIOGbIDyVgLQluMYn2R/
        Ykdd2YPyk4Oca4dX47yDWJ1XS9hDKKOPhrc7XclvHL2nrsU8ZEV31AtsA2HP70k/atsgft
        ZRc/yYpnxA52PlX08Jj4kXm4Kvtmaf0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-AELvKj1vP-CoOWvYY6wliA-1; Mon, 04 May 2020 14:55:34 -0400
X-MC-Unique: AELvKj1vP-CoOWvYY6wliA-1
Received: by mail-qt1-f198.google.com with SMTP id x24so616383qta.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cx2x2osOhFhdNBb63MzyccRaN5HnojRzjf9rZPXLgjY=;
        b=kVPkHwpGn2baB1o9vZs7aNGW3M/dy6rSIv5AVxO5FM0btQzoqeAgrXCZNBfEj3CTFO
         G9H+EnPNZXzW7rBCgXv56UzdNM97vQZLemAOpCr2c0gawzf7866d6Lq8KoCG1uV04hdS
         abr5NJovE0xkA3IyvXENQrR7NKBIBiAljPZyJx0u1WmFzqxvXYIXMyowt4zDjI3knC2O
         mCkT5M9WWi9E0iGLYCSq7b/yYFd4Hq3K38tN2XBy3lxLWVz8ZeTtmiWadsAdneP3/6In
         9jw7/4GShHtoE7tBa90qcSqpeE6q7imdcEY/68yDJcqMeuh3Xwigd1geY71S9RfBZd0S
         aEdQ==
X-Gm-Message-State: AGi0PubQF2Fjn7pc0j+0vGmpxDIg4Cx+UvAibho2CQ5A3GeL+zsuLn01
        Nt90ANII7rmnOGEvmQsQWZE3l2BWM5GA0vhq8Byga2URN9nlai5lvTFXnz68v+DZRyltkHFsQaG
        BkBM7Rxu3D7Dzg0ciLDqgSTs/
X-Received: by 2002:a05:620a:34a:: with SMTP id t10mr697077qkm.414.1588618533055;
        Mon, 04 May 2020 11:55:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJq+J633mf+y1J7g3ZxshaxAtV+nb5njYJJPi1tK5geEfdEQtTK5uET4NS5qWHnowkUi6cMNg==
X-Received: by 2002:a05:620a:34a:: with SMTP id t10mr697048qkm.414.1588618532684;
        Mon, 04 May 2020 11:55:32 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p24sm12299786qtp.59.2020.05.04.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:55:32 -0700 (PDT)
Date:   Mon, 4 May 2020 14:55:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 0/3] KVM: x86: cleanup and fixes for debug register
 accesses
Message-ID: <20200504185530.GE6299@xz-x1>
References: <20200504155558.401468-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504155558.401468-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 11:55:55AM -0400, Paolo Bonzini wrote:
> The purpose of this series is to get rid of the get_dr6 accessor
> and, on Intel, of set_dr6 as well.  This is done mostly in patch 2,
> since patch 3 is only the resulting cleanup.  Patch 1 is a related
> bug fix that I found while inspecting the code.

Reviewed-by: Peter Xu <peterx@redhat.com>

(Btw, the db_interception() change in patch 2 seems to be a real fix to me)

> 
> A guest debugging selftest is sorely needed if anyone wants to take
> a look!

I have that in my list, but I don't know it's "sorely" needed. :) It was low
after I knew the fact that we've got one test in kvm-unit-test, but I can for
sure do that earlier.

I am wondering whether we still want a test in selftests if there's a similar
test in kvm-unit-test already.  For this one I guess at least the guest debug
test is still missing.

Thanks,

-- 
Peter Xu

