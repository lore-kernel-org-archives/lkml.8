Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7BEC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670E92073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P528IEdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2KU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:20:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgD2KU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588155654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvmAgJ1OCqs5BSQtwGJP89ITCctRl3ojWHctS5awxpw=;
        b=P528IEdk04/iYzcxSpJ6P0bg7t6A7Cn9+AteIY9oM5lvXt995bMNkSW8eN52WA41UGn1uF
        g/8QtoWNNpKMojw1E5mjSm8t2hbmJwvRcH1GeT8oOGdl4XnRYczEJmO0/oeQn3yVP+tXLy
        PPhpgqVBMN8ASVcwA0hVrWcZ6+wV8BE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-yni3fb6IPzW8I7Z3AT3PfQ-1; Wed, 29 Apr 2020 06:20:53 -0400
X-MC-Unique: yni3fb6IPzW8I7Z3AT3PfQ-1
Received: by mail-wm1-f69.google.com with SMTP id o26so812528wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvmAgJ1OCqs5BSQtwGJP89ITCctRl3ojWHctS5awxpw=;
        b=BvotG4P6r3IHSKET1Yp42u82SOv3zBVWOXpISRFaLgnp04C6gOCBs2FFHSpRouQuqn
         Zwwe34af2+g7aFXkebqUtpwc2umRKhfoRC1r2BpqrsfnyVv1hUkc91DZzj/REOmsi7po
         9d4gc0R9uRQEGV2p/5Cb3rOoKhrGok927UbhtB2jZA8ekQ6Mchd3FeuBPnonIHrx5nS5
         ObNrY43BxxjuwvtMI9YSE4Bw+wnPuojtgUQUR4fUOvnP2GPn//qJbfh/hpC45j8XfIUw
         4UpLQF3zhIju9dfBA+TxNY45zW1GVWrkQGBjtWLMbkj+NBXINvnrb0MHYcfTc4haSQI9
         lYvw==
X-Gm-Message-State: AGi0PuYlJGTf2ha/qJUcy6V48zxvCQi1hVxc3uSP2JDmsrA8R8sOOsCa
        czDv5RWQim52fBCY8ISn3V5dqF2NIdswQd9mpVC5/vwLBgwW1F8Qd0qe5xdK0wPrqtRL61KelIM
        udzFPytNtXZRa2al08l4CZDfq
X-Received: by 2002:adf:f748:: with SMTP id z8mr36689666wrp.45.1588155651892;
        Wed, 29 Apr 2020 03:20:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypL7W87TuCEBCh4Hv8OBMcyMuv2V+tdXaHVIwWppnAllxcN7DLIJZP5w+iV7A/NbopWJbzldOA==
X-Received: by 2002:adf:f748:: with SMTP id z8mr36689638wrp.45.1588155651690;
        Wed, 29 Apr 2020 03:20:51 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id t67sm7743622wmg.40.2020.04.29.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:20:50 -0700 (PDT)
Date:   Wed, 29 Apr 2020 06:20:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jan.kiszka@siemens.com, jasowang@redhat.com,
        christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429061621-mutt-send-email-mst@kernel.org>
References: <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429100953.GE5097@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> That would still not work I think where swiotlb is used for pass-thr devices
> (when private memory is fine) as well as virtio devices (when shared memory is
> required).

So that is a separate question. When there are multiple untrusted
devices, at the moment it looks like a single bounce buffer is used.

Which to me seems like a security problem, I think we should protect
untrusted devices from each other.





> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

