Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7065C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA952070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYE0Mo18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgBQTwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:52:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729129AbgBQTwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581969120;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=0/9BSmLX4MRCy8kIrzvmMwpvIQmbMHKkCMt9qWFLNP4=;
        b=UYE0Mo18oa2J8nGsr3IPXkOvUblVuTo1XWsi9xnDnss0VluEI1yguGDuxQ4Er1thxrjpNc
        VjG1bS+9btmwPnJI3rxMgJFVJ9ToP1IDHBHk1vnosvpBHDS++k7Yn7sy5vnCTXJCq93Awc
        23acj0vNWOG43b1Ur1WSS99Q6Jms7TE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-5ob-uIDMNU26raNXDxdw3Q-1; Mon, 17 Feb 2020 14:51:57 -0500
X-MC-Unique: 5ob-uIDMNU26raNXDxdw3Q-1
Received: by mail-qv1-f71.google.com with SMTP id e26so10920324qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0/9BSmLX4MRCy8kIrzvmMwpvIQmbMHKkCMt9qWFLNP4=;
        b=tHry4C4zrF6R8m6p7I9ptqZiJ90ICiERXiXQQwcfYGB0jaWKnls08JY1tKpYJZk/c8
         N1vH+fHxMCmjVTK2VJ6ua82l83t5Bf7Pk/pbfiFvEC5VyydFvuR1cBHp5j4eiXYoyJk5
         caye4j5YM6wq9QrksvEf5FItlcSylIhOGn+cfAS0hBbWOBsl1NOj9MlYLPC4arWLCcjr
         RJW2LAcQ26QdVsSSPCl6kvzyUBCv85q2g2BQqKN38NsRVNpy9/6JvexdUDIZj2hzVMc+
         lubAXDZjhrfzzBGNMVx2dzA1gGjRmYtxtzQbkPRsJrD2+3eVjHo5tDPGHTv0z/HUK+Nd
         Iz0g==
X-Gm-Message-State: APjAAAXf+gTUhC9W+snLRt4ECEA8iVKLBiqqKlBC2471j7ANDWBCCyk5
        G2tGrN3r83c8WUOVgnJ+UXImYWJy83Reh5+wG4sVN7kq3PjWMwYUzyZXUrioC2lY9WWM2C1OKze
        M1rY26zqzGlLm0HpRp0p2J429
X-Received: by 2002:ac8:130c:: with SMTP id e12mr14535711qtj.233.1581969117011;
        Mon, 17 Feb 2020 11:51:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmg2sQNzWisHtmSLVfDDkPHzKsic5owvJktuDRJGbM8YMd0Ljg16zsnFdj3keLyUWMcTSESg==
X-Received: by 2002:ac8:130c:: with SMTP id e12mr14535701qtj.233.1581969116833;
        Mon, 17 Feb 2020 11:51:56 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z11sm720869qkj.91.2020.02.17.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:51:56 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:51:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove deferred_attach_domain()
Message-ID: <20200217195154.5gkn5bzbkjg7x35h@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-5-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-5-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The function is now only a wrapper around find_domain(). Remove the
>function and call find_domain() directly at the call-sites.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

