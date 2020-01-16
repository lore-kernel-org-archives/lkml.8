Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB122073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lQeRJkmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbgAPThc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:37:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40738 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgAPThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:37:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so23901464ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/6nixoSIoKE6eZ+cJNMdmi8y/6oky8cFSXcKfYMtxQ=;
        b=lQeRJkmRDyrHLNcLnxExOdsvsc6kYdTstdedfLJdxBc2Hb3NbgtxdXq880Yfcy82zG
         +B+Vj80m+NtyaXkPaj1oRCBWHZw+GQgQ30H1LhlD5+Kga/+5lKOt7WrVHgEFRKopB44a
         RFWPlwiohqMayaO3MO4ek0DoQ9Ff1EfnmeIyaoDhopImoqVNumyuBCo9PDfxM1ouTBsY
         DWUVkhfv5yaDU08IGVaS+B0+gdsSWikaE2NGLkHrZDFpqeqVJ+l8SQOT1CzlM+6bJ+Ym
         K8Gxs5sKXmBofKEQrueCfPV/lt1FSA0dU8fbsE/pFEJOEhaTyAqPZHacl3xhe+JttXvx
         cCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/6nixoSIoKE6eZ+cJNMdmi8y/6oky8cFSXcKfYMtxQ=;
        b=Knz+6PAlutt+55+hQYMTf5vfi0PL7SsIq/vEOZl+xq4BR5Ct/VAicoZqZMU4ijzLlk
         S78uVZsujjYTWNIB1t/ATui346i1oySRd8JMFuEhdKnrOopttD96nrAVLLzVGvzq4jzK
         usW9lMXZdK/j1lP/yJXYSjyEOepoiMDSnaTgBVIqAxJQpIUjdj3LMrfaTfRZb2SSidnD
         jJDY84sP/ZzXyfp3bCf9NGlUH+hRFjfYgLca8Yl3yIB4icb3AW5TEIEchuiVAsGgN54g
         j+i+qScU5c7r0rJ2dd4Tbn2BDVtfJYyJyFHX9yQl3zT3U6Yr45RE1DxCxPQera4ci2Ew
         xl/g==
X-Gm-Message-State: APjAAAUgGj9TDd01/GN87GGNOxZXfddTPNJ0Re0MViWN47h76O8utfrs
        loh94w/oggOk6nXpCtMUteM1I9ST3UxgqK+RBUw3
X-Google-Smtp-Source: APXvYqwKAWhKu2+URonvJ2ikEe5O/sYBlf20qhEgS2M6oEN/BhsztPpWGHIRzliVuWewDjHKHrmByY0zmqg+gZCZzlw=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3313585lji.93.1579203450159;
 Thu, 16 Jan 2020 11:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20200113150331.34108-1-yehs2007@zoho.com>
In-Reply-To: <20200113150331.34108-1-yehs2007@zoho.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 14:37:19 -0500
Message-ID: <CAHC9VhQTa9VcO9Yq4e36zd8ZAVNDb3_tA-uSgmH_aMX2p5QXLA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove redundant selinux_nlmsg_perm
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, tyu1@lenovo.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:05 AM Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> selinux_nlmsg_perm is used for only by selinux_netlink_send. Remove
> the redundant function to simplify the code.
>
> Fix a typo by suggestion from Stephen.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 73 ++++++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
