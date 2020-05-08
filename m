Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE08EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCF720725
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgXqGQ3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEHQFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:05:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbgEHQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588953939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzNGIg9wCojzQE1LmaJBjj2Riqjs4hcmRh8uNcepGBA=;
        b=MgXqGQ3uPuCIgaKvqYfvhzNiRjI9LeWvaeMdPksBj58QFl+Elvu5ih+4Zl/vwMfv56p3dA
        2fM1cVrrI2k1LwbyN/LH7nn7iSnYXvMjfd3llOHGdHQSJm6gz9hht0puV78vI49b8ehkUS
        QYj/hnV2LjDMmciZI/kzxY9DNIFxycQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-cVBR9jyhOSaLgXYgcNzYXA-1; Fri, 08 May 2020 12:05:37 -0400
X-MC-Unique: cVBR9jyhOSaLgXYgcNzYXA-1
Received: by mail-qv1-f69.google.com with SMTP id cr5so2227174qvb.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 09:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SzNGIg9wCojzQE1LmaJBjj2Riqjs4hcmRh8uNcepGBA=;
        b=Y4GO/yQ2WhnNqHR1+oei0trCRcxdyI0wmCPbRPuESjg4W7UCCBXqWQOc4xy3+HV3l5
         mjtOtQpwCXK3ezuCCWROk+xy0wJCrVLjwHVjEROLqbtWjIl10K5eDTJxdrFhytqSXvjF
         8OuuX23shPoPHdpB0hHbKknK3wQUOhcfSBcKs2tdwpBH9rcsP6x5yH3WCSjSiwjCAdpR
         Rz9OzRSiWCGO94Cpm+et0GK1RN1o32iekFRjU1vfXwYJsh5EY4p8K9a8YrBFVMtqnwGx
         7eqmuOUqt9Lh9NvJ4+ISTahn+OFkUsX80ht88APyZyZfa51zilbpQ7yo/z8mTMHx+Y/9
         qb9w==
X-Gm-Message-State: AGi0PuYua6cMqzP4olR1+FVNJLrGuyexeSLqF5R+aUMc5HGdTVzOZaNC
        o/aVjauiQueL/Y+z4TMVxD9tXBk+QW29dkc6LzciYRPwjtg+Bux//KsZFCWHzMGMDIPmLbBjm0x
        HVtLg04fVzCp7LRf2RBZdP/5d
X-Received: by 2002:a05:6214:42b:: with SMTP id a11mr3487475qvy.186.1588953934337;
        Fri, 08 May 2020 09:05:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEZbUB9JpX5nQ5mBjKk/50jvAujXFWp5fDu/JL2c2EKEzr4jVhJs06Er18X2ZJXYM9xvwVNA==
X-Received: by 2002:a05:6214:42b:: with SMTP id a11mr3487445qvy.186.1588953934079;
        Fri, 08 May 2020 09:05:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t7sm1700790qtr.93.2020.05.08.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 09:05:33 -0700 (PDT)
Date:   Fri, 8 May 2020 12:05:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH v2 1/3] vfio/type1: Support faulting PFNMAP vmas
Message-ID: <20200508160532.GB228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871568480.15589.17339878308143043906.stgit@gimli.home>
 <20200507212443.GO228260@xz-x1>
 <20200507235421.GK26002@ziepe.ca>
 <20200508021939.GT228260@xz-x1>
 <20200508121013.GO26002@ziepe.ca>
 <20200508143042.GY228260@xz-x1>
 <20200508150540.GP26002@ziepe.ca>
 <20200508094213.0183c645@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508094213.0183c645@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:42:13AM -0600, Alex Williamson wrote:
> Thanks for the discussion.  I gather then that this patch is correct as
> written, which probably also mean the patch Peter linked for KVM should
> not be applied since the logic is the same there.  Correct?  Thanks,

Right.  I've already replied yesterday in that thread so Paolo unqueue that
patch too.  Thanks,

-- 
Peter Xu

