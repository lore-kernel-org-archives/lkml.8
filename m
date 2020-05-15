Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D87C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BC62074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdB/1CGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgEONEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:04:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgEONEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589547860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9P1wHySLzxRU4jlM3CaGwEcVH4Xc+9sJuJmZ3RkQbQ=;
        b=hdB/1CGAZRjVDhqG0dlixJqEISZyGlc7p0vgt04sLwWqOUb0zH/ZOMyk8qSSx+N5MOBNKP
        I6u8hHL5jngXvA4PlfoZdxlD1vxpYTc44xgy4sdeTtNdROqj+BkpCEO5kTzFIbI6pRYOPj
        d6SHrra+nDdHnyfBP2m9kIwKsDm2orU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-1BKl-PSFPRyCRLQPwKBL7Q-1; Fri, 15 May 2020 09:04:14 -0400
X-MC-Unique: 1BKl-PSFPRyCRLQPwKBL7Q-1
Received: by mail-qt1-f198.google.com with SMTP id t57so2345184qte.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9P1wHySLzxRU4jlM3CaGwEcVH4Xc+9sJuJmZ3RkQbQ=;
        b=WdrN47rTDVQdpSRBsE1lzJO2tuGzLleJIyyWmu579jcgTYDotEhJkntq1jgH5BbVzA
         Tluo4XFokbgvrlgjnty1+gA2JV1Y6pDyTf8EoWV4TP0SJKngHOXh/Kpq21YKNiOntzHJ
         Gm1aUdtUqLw8+xvSzNDszEPGjPXd8Rozgnny+z93Os9sf5mchAxZ/xZYITMFqFGQAYf4
         NINfTOHmWTCSOLOLAULSu48rO8lqfwWac+RwOzwea/tPz0XPQGh/KXNJ27oV9XV0YRy5
         1mDrRAAED06kMST+gmf/38ITOKtaZjafQPkJNfabu1/uyTOzO6PNTVuhxyaYXBM0vHUf
         Pz8w==
X-Gm-Message-State: AOAM533/idPjZs2qlu1I9xsCdelX/l+EnuDz6Qz2jox84XAxDX6Hwa44
        7fjBBNivxNogACNpT+3IqHGgNh8bfBmZkWCioggh4kwp19lIn0GujZ7ZagA6p3d/1GyykhVmLcC
        blcieFRB9zUcmRIGfH/vX00pL10O02FSOcyJaSVc5
X-Received: by 2002:a05:6214:13d4:: with SMTP id cg20mr3360614qvb.214.1589547853898;
        Fri, 15 May 2020 06:04:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi1B0UBGGCEAObMRpalHhMZoO8+wOs8WLL++8iuIs8cjiM63zLXDpZtbnW9R9hy/gk7q9U/9q8Y3jYAjf5MgA=
X-Received: by 2002:a05:6214:13d4:: with SMTP id cg20mr3360586qvb.214.1589547853602;
 Fri, 15 May 2020 06:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
In-Reply-To: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 15 May 2020 15:04:02 +0200
Message-ID: <CAOssrKeNEdpY77xCWvPg-i4vQBoKLX3Y96gvf1kL7Pe29rmq_w@mail.gmail.com>
Subject: Re: Setting mount propagation type in new mount API
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 1:40 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello David, Miklos,
>
> I've been looking at the new mount API (fsopen(), fsconfig(),
> fsmount(), move_mount(), etc.) and among the details that remain
> mysterious to me is this: how does one set the propagation type
> (private/shared/slave/unbindable) of a new mount and change the
> propagation type of an existing mount?

Existing mount can be chaged with mount(NULL, path, NULL, MS_$(propflag), NULL).

To do that with a detached mount created by fsmount(2) the
"/proc/self/fd/$fd" trick can be used.

The plan was to introduce a mount_setattr(2) syscall, but that hasn't
happened yet...  I'm not sure we should be adding propagation flags to
fsmount(2), since that is a less generic mechanism than
mount_setattr(2) or just plain mount(2) as shown above.

Thanks,
Miklos

