Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25CDC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9475D2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLCKeetf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMOXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:23:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726074AbgAMOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578925404;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=YEhK+4kl7cQbrvushadVJymcfezZsR6Q8L9f9dsnLPw=;
        b=MLCKeetfd2G6APAhkJ6ze0VBpNIcq+uFRovGwvyxVKXo++tBbJFWGQIJrBdtWO+LmWt9Zx
        aJkQ5cRVyibLaOkS4VC2hd/u3b3c99CXdVwsYEIJBKaFLVTSXpY737IWUxoIpNI39Uwz6F
        ndPAhAUqzfNH8qWrE/GCqXJoPlHGeeY=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-NROy4n8MNDCAzdxRoG4osA-1; Mon, 13 Jan 2020 09:23:23 -0500
X-MC-Unique: NROy4n8MNDCAzdxRoG4osA-1
Received: by mail-yw1-f72.google.com with SMTP id e128so11829054ywc.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YEhK+4kl7cQbrvushadVJymcfezZsR6Q8L9f9dsnLPw=;
        b=r6U83vuqeJhGKGD5kSqML2cTv5gHdW//wm+lQY0zHXX666lrmkjMTxKJSXWSHu0Qae
         GkbEf242gEXR5wTYvT5wnKZplgK00/HtbSZUP4LwjijGjC5XMYR2f5uYI16H/k8zcrRk
         SUmfykNlFEYhYbQAaqbAl9SWk55wsuR19pimkpeLQg2wyQOyGHzKFwD3oXwaKKSM/pgi
         YovesYicQlvR57ytn+7uQVFwM+vZrFIQA4uOB2dCZ2UPe5yEUYosLKUC07h9yKNiupUq
         cEJH+5SsMTYRn4UC7+4IGM72KxHu+tSaZLqyuirXE1xb8VUrbKSp6btUWQe3dlrsTqYf
         hVlg==
X-Gm-Message-State: APjAAAXrX5/jcQ4AQngLFzSG1n0SpjFajqtrucXMN95NxtrBKhBLoD8g
        Y1LMKQnpd+a6IikBlf8mrH9KNdmfgB0KFdsOQuO9lcqpEbEO3cAeM3hP2rR/nv8ZRFtyyVMGV+y
        U/ALqeECm8zk5+oPcQ7omVXDZ
X-Received: by 2002:a5b:881:: with SMTP id e1mr12665859ybq.81.1578925402546;
        Mon, 13 Jan 2020 06:23:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8Cd0MzX2M/xO0EjxnCiOEj6aO2wKBf8SdQtc0aBJG7TXuNVUYV1Z2iceSZ1vUtJjado4Q3A==
X-Received: by 2002:a5b:881:: with SMTP id e1mr12665837ybq.81.1578925402251;
        Mon, 13 Jan 2020 06:23:22 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t140sm5074469ywe.28.2020.01.13.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 06:23:21 -0800 (PST)
Date:   Mon, 13 Jan 2020 07:23:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update mailing list contact information in
 sysfs-class-tpm
Message-ID: <20200113142319.r2gfnmw254owobue@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191025193628.31004-1-jsnitsel@redhat.com>
 <20191028205338.GI8279@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191028205338.GI8279@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 28 19, Jarkko Sakkinen wrote:
>On Fri, Oct 25, 2019 at 12:36:28PM -0700, Jerry Snitselaar wrote:
>> All of the entries in Documentation/ABI/stable/sysfs-class-tpm
>> point to the old tpmdd-devel mailing list. This patch
>> updates the entries to point to linux-intergrity.
>>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
>/Jarkko

Hi Jarkko,

Should we put this into 5.6 as well?

Regards,
Jerry

