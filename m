Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC817C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1502075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UleU/xOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAPKUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:20:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:20:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so3144762wmb.0;
        Thu, 16 Jan 2020 02:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cffBxyxsROM+/0/ZJcbGa9AlfvTIPNPDZ4yww6KPzdw=;
        b=UleU/xOSK8N7u43DrHLzWMUiGKBUVmvf4NG3BW+j2E902pFM20MmTqvRVWznv3zZcd
         k1A9P2UypTarIy+8hdymW01NGoZ45lXhFtHilxlfl5u2FkjC2lkRMhkffAhsJhHFdLH8
         gyTGFncmCKxUqnteVaKEsLWsDVTSuOOiyA6GQdg6rbxKHDKEE9VD+munR1341Y6rH6hg
         f23xuUJJMBlV/IgeRfNWqWH3O5cTXdJRkiC8709E9eLmEIjGlqwmw/TALnIjAAgsY38t
         Fdvx6OqHNMw886eR2VeQMTBnw2eVvYzRSAOk3L8ldCfoWdebqBm91G0bMEbrX1y/QPx9
         I9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cffBxyxsROM+/0/ZJcbGa9AlfvTIPNPDZ4yww6KPzdw=;
        b=QSYkdQFFBUZrFN7PrvQjYOYn1XsF7bZ0uc0xs29MnlAL51/2/0Ap2dg4kH9hcz5Nch
         iUFweAlI4V+DDnNJRHGUtOW6eSV0SRTE45r3E7EFR5fcdgVFx7VtegIqctotEkIbDqnT
         AjC+QjbSrpsoiGUO712ZrsLlQHpEU3dkpKh4sxnr8ZpGUAMFh74r8VLSBpUQlNd5kVH6
         7MHWmUDWrn3nZ22GCuR21biPqY/un3jO75fnIhR3cPTr22tAwRjBDnGcZUobPTID5XKp
         wdjIq1cqMWEe9/Yp/687c9NMko7xiM/9ypl42LTZvpPruXbGbJZpg9kGqBO6apJE66fS
         K8Zg==
X-Gm-Message-State: APjAAAWaX+e6ygu3DQVUbUI5o14tC83O3SKKZiPZjsQXHfo2U23RQPem
        ZDF9qTiSeU6+wOaz6dix2PA=
X-Google-Smtp-Source: APXvYqyixnzNHxNve8mkVqZMFcLxgbWmryQ2qrm6OIpnl/mdReSrpHA8uozzfJf5EPuvskHUD2fo8g==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr5484979wmk.15.1579170042923;
        Thu, 16 Jan 2020 02:20:42 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 16sm3825698wmi.0.2020.01.16.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 02:20:42 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:20:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v10 00/14] add the latest exfat driver
Message-ID: <20200116102041.i52l3eoas7xrhlxv@pali>
References: <c4fdc6af-04c2-81a5-891d-5a3db4778caa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4fdc6af-04c2-81a5-891d-5a3db4778caa@web.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 January 2020 10:43:50 Markus Elfring wrote:
> > Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> >
> > Next steps for future:
> 
> How does this tag fit to known open issues?

Is there any list of known open issues? Or what do you mean by known
open issues?

-- 
Pali Rohár
pali.rohar@gmail.com
