Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DAAC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE42072B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtKSH9DO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgASJ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 04:59:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726538AbgASJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 04:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579427971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RBsez8nF60syx6uO6vVLgbM1Sl7Se03CnUJjUyZLN0=;
        b=LtKSH9DOyfw8EF9G03ARlTHQMwKRbs3PRTcM/l2nmUGBH0OerN4r/ouxzYU/Ia9fbotOg2
        sZtOfJj61KdOZ5yditstL8k3awVCa7ow9npCy//qo+Qm9zCiaQkj30Q/2VKQ9j0UzL/H3m
        xF7DSLdCp0qdq9mP2RcNOryKkWmW1Uw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-DUJGRTWCNkWyfpSJhMr69g-1; Sun, 19 Jan 2020 04:59:30 -0500
X-MC-Unique: DUJGRTWCNkWyfpSJhMr69g-1
Received: by mail-qk1-f199.google.com with SMTP id w64so18643488qka.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 01:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RBsez8nF60syx6uO6vVLgbM1Sl7Se03CnUJjUyZLN0=;
        b=RuVq6xwVnsqG2ggjJ64QohIDU8EFCunywRUj6PYQTzMKkCK4oyguMYcE/61b98kdvQ
         a9jaEN0xVOF0AFleqOrV7Ak0hHOkU9UOhaFFQTDnAF/BrVnoQ4r/FpY0vAchoAQwHrtw
         ENO4ssSvZuLQFF5eRfug0dmqsbr/HCoqur5NfzTpdQ24Cbc7Cf0X3UuoQpq7VEE5r7x+
         tO5ALeuV6Xsiis0gJPbIPR7UzQSFqMPmyL9JN8DgE6kI+JyA0oexnPmzKi3yz7eUIPsw
         ALKSvJot++TXN6xQ+/cXP+3FVJ/GqrVZvwkGXh6feaBdLHHXPNCDMEAnM6ox3/gpIRmn
         ay0g==
X-Gm-Message-State: APjAAAXX+pmQ59j6fvkugIROL6cedTcxwt0As65SJF98JMe+D4WJR9ad
        e/vPpxGQwCIQdOMbUF3aXH2MlzvjXZGycFg55win23jsNsnaKMgBeKBNhapmQMuuiYj1RhGDF3a
        dxNky1/9bi1jbFb0OWY5WpVI/
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr45426271qko.37.1579427970355;
        Sun, 19 Jan 2020 01:59:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQHb/giklfzhDUxPQigzeGmKW4ihwH4cIVdw4qNSRvx+9dDqW3AslJF469jKiTK5R9qVYMmg==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr45426237qko.37.1579427970157;
        Sun, 19 Jan 2020 01:59:30 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id h1sm16162903qte.42.2020.01.19.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 01:59:28 -0800 (PST)
Date:   Sun, 19 Jan 2020 04:59:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shahaf Shuler <shahafs@mellanox.com>
Cc:     Rob Miller <rob.miller@broadcom.com>,
        Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20200119045849-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 09:07:09AM +0000, Shahaf Shuler wrote:
> >Technically, we can keep the incremental API 
> >here and let the vendor vDPA drivers to record the full mapping 
> >internally which may slightly increase the complexity of vendor driver. 
> 
> What will be the trigger for the driver to know it received the last mapping on this series and it can now push it to the on-chip IOMMU?

Some kind of invalidate API?

-- 
MST

