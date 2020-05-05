Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256442073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="oiObcX6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgEEWoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgEEWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:44:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF6EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 15:44:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p13so1908533qvt.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=C76LIzi+5JEntbZy/qpJ0FbBUCkVF2NVl+l3fJXGdsQ=;
        b=oiObcX6jBSeqxuVh18DxaP4VKpyAStp5GGdizA7cYt7WmM6dWbuGQxBEL+VVoIUoDS
         ku8zmELuSS6v2qq/ewa5IGUmKfU1iJyBxNXu5tieOc9Fg7O/h6ARn4CbxdSx3sngwN7P
         EEXC+owDs1Gi0O0EncsKBljKwVT4X2TuPXsU1rFQgyxcqNF9LjhT02wYkxMfR8aUXww7
         p6+++CupbZ6LKHySeJgjAwRgwXZbB1Kin250GH4Raw+JGTZMtxqoUDIWW18Zst6JPlnq
         xpCTHnxhduEM9lWP+uY1GPfZ458TP3yzoWOnG3LUPTIbN+CX5FTJVLp25HD2Jh/Ebus7
         KYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=C76LIzi+5JEntbZy/qpJ0FbBUCkVF2NVl+l3fJXGdsQ=;
        b=kQrFkHl8q+vbhKsPPvhZOXILJNOK61oHvecUsekKqGFTxNTKI3Ar7y6dcqrFP5/r2o
         MHIW8udsORJ8Ez2QdiWBxsGk1J5+3dSUELXlhbWcV+FMX4LZUtW3ta5gqTBBH4pyuv9U
         Qp09zXkMheDEX998l0RJfZ9eyi9mqCJor3MyfGDw3yzYJ6OWDOxQ1RnEQ5hrUk9NJjub
         N/ZiEqPybukImcyytTAIFJPisBbx3TRucSm7oMWHFtew7h+vTD1JbSAaN6/+k7JkbQhW
         IKOSlTgGZ58CNfqEkTWPnTSsiXdjxqRaxD/1cn/p/iGFbPkzCXnp3DdrnXRsDfMKgu5F
         klPg==
X-Gm-Message-State: AGi0PuY1WGGuM6/UaUuKDZIomXcKsW1SdpoyHjqHe7w1LpB1o/biKrJR
        ICuDwJrPXRwnY1ypIX+ZDN2tmQ==
X-Google-Smtp-Source: APiQypLneX5+0+lcyzB0u8ws0ZzKSXPK5claKysblIbIb96NIdVrq1gVior7r/FubUDA45y7URkDvw==
X-Received: by 2002:ad4:55a5:: with SMTP id f5mr5000177qvx.133.1588718646066;
        Tue, 05 May 2020 15:44:06 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id u11sm3058126qtj.10.2020.05.05.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:44:05 -0700 (PDT)
Message-ID: <c092c2f7659d344744bd4400bccc2bb6f774b998.camel@massaru.org>
Subject: Re: [PATCH] docs: s390: Fix wrong label Guest2 instead of Guest3
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, akrowiak@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 05 May 2020 19:44:01 -0300
In-Reply-To: <20200505094632.0d34f72b@lwn.net>
References: <20200430221238.101838-1-vitor@massaru.org>
         <20200505094632.0d34f72b@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 09:46 -0600, Jonathan Corbet wrote:
> On Thu, 30 Apr 2020 19:12:38 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
> 
> > This fixes:
> > 
> > Documentation/s390/vfio-ap.rst:488: WARNING: duplicate label
> > s390/vfio-ap:guest2, other instance in
> > /home/iha/sdb/opensource/lkmp/linux_doc/Documentation/s390/vfio-
> > ap.rst
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  Documentation/s390/vfio-ap.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/s390/vfio-ap.rst
> > b/Documentation/s390/vfio-ap.rst
> > index b5c51f7c748d..367e27ec3c50 100644
> > --- a/Documentation/s390/vfio-ap.rst
> > +++ b/Documentation/s390/vfio-ap.rst
> > @@ -484,7 +484,7 @@ CARD.DOMAIN TYPE  MODE
> >  05.00ff     CEX5A Accelerator
> >  =========== ===== ============
> >  
> > -Guest2
> > +Guest3
> >  ------
> >  =========== ===== ============
> >  CARD.DOMAIN TYPE  MODE
> 
> Applied, thanks.
> 
> Note, though, that while the patch does "fix" the warning, what it
> really
> fixes is (as suggested in the subject) an incorrect heading; the
> warning
> was just a symptom.

Thanks Jon, I will be careful about that.
> 
> jon

