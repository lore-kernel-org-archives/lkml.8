Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A42C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FCC207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589970863;
	bh=XVubJRlPT96GrrZ5jDHQabf+HzfcQ2yoNEQJ9gYa29U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NuPEfgKfnK6Y8/VN0CpIHNZfhYxICkmKgqFjxBgJ3aMCafCDmbw6X50vZf64dbGpI
	 9qCPYcwIXaS8cUwX1dLsbF6UUS9n1ojBmdjiGOhhExxc6cHuNDz1tNJ9XNyL1TgBxH
	 hUWEfSYPqMI2wufl+YwDdPnsPcQW1C/cy/gS6Cbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:34:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39913 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:34:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id d7so2048113ote.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9NRsCAHn82ubkftxUZ5kSJRCBH4nCc/jtP3ymsxx+c=;
        b=FIIPxPPapDKTzAxu7UM0kIPF6vAts2ED9GSTZXHzgz6aJd3NdiuR9UFiMWipkFgUq+
         pOi2dyR8Y/nkZ8bWcwWXHmfe3ZTgmdX0JtHNwfvNJYStxYfyI8DasW7z200jWo32MDt2
         iy1NJYm+85F4t9jFji35kcqcHpragugG26HWd4sLVgpsmSuWqKJT8FTC5I2S9ukRk1Oy
         Rl5ZQiBl56WSNs+UbAv7mMcvyV10PXuIOHWJOh/lCnLVu87L4XJ8WvIDfe2bXq2u/pMM
         J4EKbaWWmXdbbfiIUb3nLhbohwusWIQoeJO1p3hXxKQYcAIs+N/b3uxlD9sdOgjiwGwz
         0Bnw==
X-Gm-Message-State: AOAM5312bxwdmdwQk5lF9tNLcBTb5th5eB7CZk5/KnROFAGvNsQtWBvr
        +WdqcGESVDN0EUoY1lZ5/BhHWUeW0b9rC+eV7So=
X-Google-Smtp-Source: ABdhPJxlgZArAm2RiUC1pmsRfzqwCNnAnn7Yu1P7DFwtZeQw7Ci04BDpbLAo0GnI06KfIHdKb6TZVpWlDqcNCgonvmg=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr1016333otq.118.1589970857339;
 Wed, 20 May 2020 03:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 12:34:06 +0200
Message-ID: <CAJZ5v0heg9w=k1yqkECNo9XLP2hZny_WJQv4EJq_Wh0dVT137g@mail.gmail.com>
Subject: Re: [PATCH v1] drivers property: When no children in primary, try secondary
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Software firmware nodes can provide a child node to its parent.
> Since software node can be secondary, we need a mechanism to access
> the children. The idea is to list children of the primary node first
> and when they are finished, continue with secondary node if available.

Makes sense.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Greg, do you want me to apply it?

If you'd rather take it yourself, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/property.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 5f35c0ccf5e0..1e6d75e65938 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -708,14 +708,23 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>                                                  struct fwnode_handle *child)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(dev);
> -       struct fwnode_handle *fwnode = NULL;
> +       struct fwnode_handle *fwnode = NULL, *next;
>
>         if (dev->of_node)
>                 fwnode = &dev->of_node->fwnode;
>         else if (adev)
>                 fwnode = acpi_fwnode_handle(adev);
>
> -       return fwnode_get_next_child_node(fwnode, child);
> +       /* Try to find a child in primary fwnode */
> +       next = fwnode_get_next_child_node(fwnode, child);
> +       if (next)
> +               return next;
> +
> +       /* When no more children in primary, continue with secondary */
> +       if (!IS_ERR_OR_NULL(fwnode->secondary))
> +               next = fwnode_get_next_child_node(fwnode->secondary, child);
> +
> +       return next;
>  }
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);
>
> --
> 2.26.2
>
