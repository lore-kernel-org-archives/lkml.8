Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A602080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvY4HW1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgHZLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728851AbgHZLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598440334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lR+U00Oaa72ALhBmgywIm4H6+XPgRieMfQDwiYXJfM0=;
        b=JvY4HW1uljZt1zv82sMc8r6G0t+WIHjp6qD9MXfHb2grI5PmzOlryvfZoW3NHM4rR6o8DD
        oWzgvP0r+i33vS1Lye3DDusgHh427k0obaKVt7LFSEDV6olhxMb770/qULwwQp4/0Ymda0
        3XJJuvsfU55ZVjEH6WZnKo+9DyhVXhI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-U3-JTAKsMl-qeISpKjGcsw-1; Wed, 26 Aug 2020 07:12:12 -0400
X-MC-Unique: U3-JTAKsMl-qeISpKjGcsw-1
Received: by mail-wr1-f71.google.com with SMTP id o10so397635wrs.21
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lR+U00Oaa72ALhBmgywIm4H6+XPgRieMfQDwiYXJfM0=;
        b=oDbvbX9JDggZwbmB5j7QZFaUML+9X4gzMnhouEEuPfcwuntPxsyFA8ji9J8zJsjo4Q
         qpQXYp84UJh4P+E5FR0Isz6tMhqR1UspqF87VJr6ZlbEPuhG/QGFwzZF+zqJhkjzdgAz
         3RR/5eozm7gKFvZbcjx2/nJoCpdU6jp9c52pOqGfnms5DvrRzgggTT5SS57b6iAaY1RG
         BLj+Js3Vu35BCMDTZxnrBdlwa9J1+hEpgDitIU5Ni0RpN6rf/JSAWQYCeMxo4xuMjUZt
         S1Tx99GNv3JZ6TjGh3YiLnAIaDiJ+7wEcP2KO0rkrWiZQ8A50ZECfShlsDC0pMNwxxuz
         E1eg==
X-Gm-Message-State: AOAM530ZZQjDNMqAkG94Ze+P0KbsthWx5vnzG6BDvsZraShNn460wFb0
        4ffkeAnZrqmKMOKr+reNG0ogniK66D8FUyoKPA1osREy657Tof4nJ/FGw/IL75I6Wy4v1uoigXH
        ljPP/G0y83FRMG6tvxE3meV0v
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr11854990wrr.365.1598440330948;
        Wed, 26 Aug 2020 04:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0rObmmQMjGOaXLjfOhZSPZT6w5SFheSV59yGDYZ9gFY089eygMzryPx1d3YNhKUDJ9uAvUg==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr11854967wrr.365.1598440330699;
        Wed, 26 Aug 2020 04:12:10 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
        by smtp.gmail.com with ESMTPSA id 128sm4844463wmz.43.2020.08.26.04.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:12:09 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:12:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 1/2] vdpa: ifcvf: return err when fail to request config
 irq
Message-ID: <20200826071200-mutt-send-email-mst@kernel.org>
References: <20200723091254.20617-1-jasowang@redhat.com>
 <87ec5f62-4d99-e7b4-00dc-28664f8eb111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ec5f62-4d99-e7b4-00dc-28664f8eb111@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 11:52:09AM +0800, Jason Wang wrote:
> 
> On 2020/7/23 下午5:12, Jason Wang wrote:
> > We ignore the err of requesting config interrupt, fix this.
> > 
> > Fixes: e7991f376a4d ("ifcvf: implement config interrupt in IFCVF")
> > Cc: Zhu Lingshan <lingshan.zhu@intel.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> > index f5a60c14b979..ae7110955a44 100644
> > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > @@ -76,6 +76,10 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
> >   	ret = devm_request_irq(&pdev->dev, irq,
> >   			       ifcvf_config_changed, 0,
> >   			       vf->config_msix_name, vf);
> > +	if (ret) {
> > +		IFCVF_ERR(pdev, "Failed to request config irq\n");
> > +		return ret;
> > +	}
> >   	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
> >   		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
> 
> 
> Hi Michael:
> 
> Any comments on this series?
> 
> Thanks
> 

Applied, thanks!

