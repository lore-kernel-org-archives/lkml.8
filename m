Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CDBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48BD20882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJazi4uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgATMJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:09:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579522158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ils+V+DNAQCUc++KUaM/zwaIHOd66hKtcZoyoJKDxck=;
        b=XJazi4uvc8FGdXK0hA/jHe7Y8jCenZUr+XMAMOm7NMAJZeomzdavszjWLOjkuS4rsquFSr
        68RtAPmdDl1lOAzTOOu4HdaUlVh63Aps3Eyg3bVcGgoLyz6TIZIuAC3AKF9tYZCHqw4gUY
        Yi/uP6+dDeRNtZ7WY1T4ZP4RG0t2dOs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-YLqA3ww9M4G7YHgy9rQtiA-1; Mon, 20 Jan 2020 07:09:17 -0500
X-MC-Unique: YLqA3ww9M4G7YHgy9rQtiA-1
Received: by mail-qt1-f197.google.com with SMTP id m8so21000627qta.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 04:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ils+V+DNAQCUc++KUaM/zwaIHOd66hKtcZoyoJKDxck=;
        b=CCB2a/s11VLKdlTxEJkIx5B1dAzCo3/fhlppL3xkRUKjHW9XX4PtY2+naK7np44hFI
         5J4SwVpOXfC50QD/4jPWhg0GsGKaIajC25t9UL57ukVGgb+gQmg7CrvpBsodnD5nKbvt
         1hOm8e49qIB9k3w5wgzzCWF8tTR2NZNeTOI9MLPZSrYhb6vUfYKPwD2r3QY6KiD1n02t
         YbbDAEeXGAViKY0yB5Pl/nckKuIExIqkzRhRXMfNv5S5aMJHJnEi2Qe2lnGWBcnDSFKg
         ZAk6vjDCtGhj7vFEr/3/cWbV1pk+REm8ysOG6ViwAT1NdCDZers/1ZvA6/veIhe5KL91
         KEzA==
X-Gm-Message-State: APjAAAUeWUxMqTxOTziIMrW705TB9t05qOPu5B08/r9IsVBqxYrgSUUG
        kqzsS2CirwmHIaQq38lNKGPCGhOIufn3K0tDZq7uJgkxUJq7EG9/9knNIynBx2KhkmgM8avIKg6
        Nps1j/XeTyQE9NxnhDcOg7woJ
X-Received: by 2002:ac8:747:: with SMTP id k7mr20536085qth.120.1579522157148;
        Mon, 20 Jan 2020 04:09:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPRlGSUNQNiKSICSXdcPuLibX0Cl/JMb+oCpOV4CRtRfGtUmRXGfQQVE1MHMBhude5c31BGg==
X-Received: by 2002:ac8:747:: with SMTP id k7mr20536064qth.120.1579522156954;
        Mon, 20 Jan 2020 04:09:16 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id t2sm15467285qkc.31.2020.01.20.04.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:09:15 -0800 (PST)
Date:   Mon, 20 Jan 2020 07:09:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Shahaf Shuler <shahafs@mellanox.com>,
        Rob Miller <rob.miller@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Ariel Adam <aadam@redhat.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Message-ID: <20200120070710-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <20200119045849-mutt-send-email-mst@kernel.org>
 <d4e7fc56-c9d8-f01f-1504-dd49d5658037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4e7fc56-c9d8-f01f-1504-dd49d5658037@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 04:44:34PM +0800, Jason Wang wrote:
> 
> On 2020/1/19 下午5:59, Michael S. Tsirkin wrote:
> > On Sun, Jan 19, 2020 at 09:07:09AM +0000, Shahaf Shuler wrote:
> > > > Technically, we can keep the incremental API
> > > > here and let the vendor vDPA drivers to record the full mapping
> > > > internally which may slightly increase the complexity of vendor driver.
> > > What will be the trigger for the driver to know it received the last mapping on this series and it can now push it to the on-chip IOMMU?
> > Some kind of invalidate API?
> > 
> 
> The problem is how to deal with the case of vIOMMU. When vIOMMU is enabling
> there's no concept of last mapping.
> 
> Thanks

Most IOMMUs have a translation cache so have an invalidate API too.

-- 
MST

