Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E29C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47542076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+XxOvBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGJF6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:58:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgGJF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594360708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4LnrvqT9+DNx24YkEZw2+SXe1o6FKiLlzwpTypzG8A=;
        b=Y+XxOvBjEbl9F7XdtOTWEY97JVlA/4JP9m1OmOM/D/jNmDESGG8eUGLrkYTpi8iDjHO65f
        DcJzt/9EtJvnxVr49HXpyCfTyPviqACGraWwl9LAp+nvbzYOwfs3ZJ/2BEaJ1Ey//5I0mk
        Ry4yH4AO8/XNtQnB4TbTvmqSHnhav1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-FPdUbiyrNYmCVsD8AM-1aw-1; Fri, 10 Jul 2020 01:58:27 -0400
X-MC-Unique: FPdUbiyrNYmCVsD8AM-1aw-1
Received: by mail-wm1-f70.google.com with SMTP id e15so5249118wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 22:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4LnrvqT9+DNx24YkEZw2+SXe1o6FKiLlzwpTypzG8A=;
        b=J6omiadZEEwjiC/SEAhdJDZqsBK0WzE0Nv6moqC5rx7lwom4Iz85HW8i5tSYe6FHVz
         6p7Z9wvdO8Jrr88Aof0yFf3UB0Lvs42NwTpgk4J5r2zzI6MBQU5AEJC0hj95MjFfzyvw
         JgHmuvCbTlSsdgInJnA27Ab3WRvbJlcPtKZaoo7Bj6IGfxNwUyw9PEOFDFt2Fb0ffrYO
         p5praA2zGNcgUwF9S5DZjAKK6X1NvZsBZoE7f9IJKMntOS62nVLFgZodFP0Efin0O+Nh
         BIQxToaVEIItnKvVYzY2yZHpgRed87ndLYS+KhC5jZYWX8po/ff4OO2nSsTkvmlOPXT0
         htbg==
X-Gm-Message-State: AOAM53095lDKME82Aw7nfu++auOf/JLnIyvbDQcUfSsADmGyjcey0/6v
        Og8s6NRYFdbaaUZVGKuRXuKiy/QvyijtLhY8B/mte3Nty45mz9ZC7Q7xk/qgvhgOl/ymirGlVVX
        NRyJ6GEWZPlxYgrTezmLcuvSS
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr3394783wmj.152.1594360705673;
        Thu, 09 Jul 2020 22:58:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLn6mDVLNvrd8u4soiaqjHIlkFvr4sTxn75hYjrWzq/00SA7DFxiythkthHZ5njp79o9gOug==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr3394766wmj.152.1594360705488;
        Thu, 09 Jul 2020 22:58:25 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id j15sm8366155wrx.69.2020.07.09.22.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 22:58:24 -0700 (PDT)
Date:   Fri, 10 Jul 2020 01:58:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Message-ID: <20200710015615-mutt-send-email-mst@kernel.org>
References: <20200622122546-mutt-send-email-mst@kernel.org>
 <CAJaqyWfbouY4kEXkc6sYsbdCAEk0UNsS5xjqEdHTD7bcTn40Ow@mail.gmail.com>
 <CAJaqyWefMHPguj8ZGCuccTn0uyKxF9ZTEi2ASLtDSjGNb1Vwsg@mail.gmail.com>
 <419cc689-adae-7ba4-fe22-577b3986688c@redhat.com>
 <CAJaqyWedEg9TBkH1MxGP1AecYHD-e-=ugJ6XUN+CWb=rQGf49g@mail.gmail.com>
 <0a83aa03-8e3c-1271-82f5-4c07931edea3@redhat.com>
 <CAJaqyWeqF-KjFnXDWXJ2M3Hw3eQeCEE2-7p1KMLmMetMTm22DQ@mail.gmail.com>
 <20200709133438-mutt-send-email-mst@kernel.org>
 <7dec8cc2-152c-83f4-aa45-8ef9c6aca56d@redhat.com>
 <CAJaqyWdLOH2EceTUduKYXCQUUNo1XQ1tLgjYHTBGhtdhBPHn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWdLOH2EceTUduKYXCQUUNo1XQ1tLgjYHTBGhtdhBPHn_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:39:26AM +0200, Eugenio Perez Martin wrote:
> > > How about playing with the batch size? Make it a mod parameter instead
> > > of the hard coded 64, and measure for all values 1 to 64 ...
> >
> >
> > Right, according to the test result, 64 seems to be too aggressive in
> > the case of TX.
> >
> 
> Got it, thanks both!

In particular I wonder whether with batch size 1
we get same performance as without batching
(would indicate 64 is too aggressive)
or not (would indicate one of the code changes
affects performance in an unexpected way).

-- 
MST

