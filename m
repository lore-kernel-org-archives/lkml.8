Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76CEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79482233FE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcSEy5+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgDFODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:03:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgDFODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586181778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIE9VGUaKQC5F+nmzjS1d1+OM5IgOo8Xu+l1owRvgOQ=;
        b=GcSEy5+q/otUnSc9YYtKwRI+RlCcJV9utIh3YKcqgsBER14SBxgsSAciZ5b6DWZcA8o+p2
        kreZPJxloDbArEC0ZhAzRB2TcKNsW7K/hTH6qRHFyvFcK2i325iOUa5g4gni1s8v4h9eBr
        +H34VBDBuxHVinoHGbsJ0LjV5uQDFFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ViNYe1yUOd-I7HiCpbt6sw-1; Mon, 06 Apr 2020 10:02:57 -0400
X-MC-Unique: ViNYe1yUOd-I7HiCpbt6sw-1
Received: by mail-wm1-f72.google.com with SMTP id o5so4940105wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 07:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIE9VGUaKQC5F+nmzjS1d1+OM5IgOo8Xu+l1owRvgOQ=;
        b=eDWdiTtwXsCVY46bVBLdWGGaPZssMm5vJUp5q80k1zCOYPoZYVqiknUZEAAO38qq+L
         dypSc81/cB9M1Zj/TwIaKj4BS2x/YkV8EmBUj5pJBSxgOVL3VmfdD3AoZm6Nt4oQ4mlm
         m3Kyitf8ryDyL1Ekrwv53VR78ol2Rud/bJppIelh6xzKVFrQtEliHSWB3H4fGwi32Obz
         2nVZ4EYXpC6FzqS4N5l4bonIXhrVl+Vdb5WLsBx4nRgW1rcg1zBdyfBqVG3ukiwq8X5U
         E6uFkwgdDvc4sU9W+Gw692I1JCZOFIm8lm9FpSngT4VYccAEU9LoMrPIFlX2L3if2/Q0
         t1pQ==
X-Gm-Message-State: AGi0PuZvutP6AxA3IsVvCl5eWJEE+EuTMBdnBg4pd0Zaa0pEDvN3nCaZ
        z6zCW/qy9r0pNW2LV69fQt+2msM3iNHEkEyfCwrorDA4aUM6I58yzKOyFenKWbzAtTrL7W7xAl4
        s+sHMiTX6OvTnGdB/QMHJ2tvI
X-Received: by 2002:a5d:4c42:: with SMTP id n2mr7789700wrt.178.1586181776086;
        Mon, 06 Apr 2020 07:02:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKL4+xmI91KCjCdHW6Iun/ZVCiNm2oeP85iziYNrPA4EWRYx4/NJvVV0PiOVKVLUwLXmlPIyQ==
X-Received: by 2002:a5d:4c42:: with SMTP id n2mr7789686wrt.178.1586181775941;
        Mon, 06 Apr 2020 07:02:55 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h2sm24497540wmb.16.2020.04.06.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:02:55 -0700 (PDT)
Date:   Mon, 6 Apr 2020 10:02:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Message-ID: <20200406095931-mutt-send-email-mst@kernel.org>
References: <20200405081355.2870-1-mst@redhat.com>
 <20200406130927.GA20291@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406130927.GA20291@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:09:27AM -0700, Christoph Hellwig wrote:
> Pleae just drop the code - we should not add new drivers with custom
> DMA ops.

I'm not sure there's another way to do this: this not a driver, it's a
software emulator that pretends to be an actual device. We can't
have the platform supply DMA ops here since the platform is a regular
x86 or whatever.

-- 
MST

