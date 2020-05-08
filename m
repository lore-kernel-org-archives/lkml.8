Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D48C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAAE2495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ0bdBwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgEHO1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:27:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgEHO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588948057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYevg34llcleChCJxzGI1QkRxIva9LaakKDngCZBbAk=;
        b=gQ0bdBwCPca6y192jbsU9edaxmqA+AwJ55Hw5FGyj0LNGPO8+vzw8i7MgvniA+zqatXPjT
        HvkRAPtX0Deb6EkSQK5We0PYjf6DbrcR0756GjgR1efaJh1wr3vY7V1NVve1ZXCg6wNlMs
        PNNIoPh2oB/36bwhQYghMOCEPiVTwLQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-dVOWLxIMPF2Rp03QeRKMDQ-1; Fri, 08 May 2020 10:27:35 -0400
X-MC-Unique: dVOWLxIMPF2Rp03QeRKMDQ-1
Received: by mail-qk1-f197.google.com with SMTP id i2so2207448qkl.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 07:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CYevg34llcleChCJxzGI1QkRxIva9LaakKDngCZBbAk=;
        b=CDtj3yAjMTBUHhdX+l2R5aXraIZo53EWyqWALsfmLedN2Usj2yfVnfmVA96G8s5Q2h
         xQgSXZFnvzOQx3vGPOaVkmg9wQnBz0SmvH+xBXfchlWn9J6VnCIEVlMLHfH6zE4dtUGV
         xqUO3wJKsebPfkhlM/+1E2GBK+oRp/M1qOAZgq70QXPU+pmzQuZj4TrpY6r9uFneQID/
         VMXr7J6LXMU/xEVjP6MCrpLztYs4NtMV/JITcNqQ31vnfRS8HRJi5jc3/WZv4n8s2a8j
         5tDwLCfnM0mWF/evZNLBEP/1LCooMxoHXFFkuq65QBrf7xGEIWQlcJQ9ONYpQGCh/bQX
         Dqxg==
X-Gm-Message-State: AGi0Pua0jfYUISA1w2RYFW1qB965IaneSxpDLq2gBKtbrgF9hScaWJNs
        6iAnYGAGYlvAfC+l4Nn8PvTtoYN6rtdo4h6bWci1oeHMS7CJEsIFBPysohEloVfzd6Xg5QAysvU
        n5ugJwLanadivFX+iBqVww7qc
X-Received: by 2002:ac8:4990:: with SMTP id f16mr3249180qtq.307.1588948054908;
        Fri, 08 May 2020 07:27:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfyzNMjrHzXJcHVZXQfTevH1ye6Oks9gUBxO2AF+9yojDuWFLSKiaMNeDKuft0dw9T13j27Q==
X-Received: by 2002:ac8:4990:: with SMTP id f16mr3249156qtq.307.1588948054694;
        Fri, 08 May 2020 07:27:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 17sm1262912qkn.44.2020.05.08.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 07:27:33 -0700 (PDT)
Date:   Fri, 8 May 2020 10:27:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com
Subject: Re: [PATCH v2 2/3] vfio-pci: Fault mmaps to enable vma tracking
Message-ID: <20200508142732.GX228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871569380.15589.16950418949340311053.stgit@gimli.home>
 <20200507214744.GP228260@xz-x1>
 <20200507160334.4c029518@x1.home>
 <20200507222223.GR228260@xz-x1>
 <20200507235633.GL26002@ziepe.ca>
 <20200508021656.GS228260@xz-x1>
 <0ee2fd04-d544-d03b-0a7c-90c22275aac9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ee2fd04-d544-d03b-0a7c-90c22275aac9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason!

On Fri, May 08, 2020 at 02:44:44PM +0800, Jason Wang wrote:
> Probably not, e.g when VMA is being split.

I see it now, thanks. :)

-- 
Peter Xu

