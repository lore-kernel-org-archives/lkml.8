Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B83DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B73824673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579777444;
	bh=h+f+K6AZ6muFbqVfr64JvySVeNM7UAo9/jxlI1o3+KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V04MVGMPohFcSEwy8S0mDswCLj54SioxCFKEQ+D+0ybOqpPMF2nB35NmHJzKMcsyJ
	 fq/ISvYcoNh0+nKi0GMS8n0m3iXzxGvFFUreLOxNba57UCzWZUCKFXmUmZjghGaonn
	 /t9bHIB+iSlpsoLpsipcgiDVHB/IeFL7ojFiHX54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAWLED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:04:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWLED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:04:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451872253D;
        Thu, 23 Jan 2020 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579777441;
        bh=h+f+K6AZ6muFbqVfr64JvySVeNM7UAo9/jxlI1o3+KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eavySxyUtJrh3k34yfAG9FdW+BewQ5VEmoTNvj5HR9u1eOHYgJ4RcpWnFSLhC7vwp
         TdMzST7RQPKBiTlSIiqkjmYlFNxOeFsoovSgcAOGO/pR0v6aTvfEuMFnrhmnpedpzz
         LAcFMF5tOyUBhzMAW9VcDO2Qp0uHisdlW6IgNCJs=
Date:   Thu, 23 Jan 2020 12:03:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] firmware_loader: load files from the mount namespace
 of init
Message-ID: <20200123110359.GA922639@kroah.com>
References: <4265c7f3-851d-25ab-414d-aeb3cc37e214@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4265c7f3-851d-25ab-414d-aeb3cc37e214@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:35:06PM +0200, Topi Miettinen wrote:
> I have an experimental setup where almost every possible system
> service (even early startup ones) runs in separate namespace, using a
> dedicated, minimal file system. In process of minimizing the contents
> of the file systems with regards to modules and firmware files, I
> noticed that in my system, the firmware files are loaded from three
> different mount namespaces, those of systemd-udevd, init and
> systemd-networkd. The logic of the source namespace is not very clear,
> it seems to depend on the driver, but the namespace of the current
> process is used.
> 
> So, this patch tries to make things a bit clearer and changes the
> loading of firmware files only from the mount namespace of init. This
> may also improve security, though I think that using firmware files as
> attack vector could be too impractical anyway.
> 
> Later, it might make sense to make the mount namespace configurable,
> for example with a new file in /proc/sys/kernel/firmware_config/. That
> would allow a dedicated file system only for firmware files and those
> need not be present anywhere else. This configurability would make
> more sense if made also for kernel modules and /sbin/modprobe. Modules
> are already loaded from init namespace (usermodehelper uses kthreadd
> namespace) except when directly loaded by systemd-udevd.
> 
> Instead of using the mount namespace of the current process to load
> firmware files, use the mount namespace of init process.
> 
> Link:
> https://lore.kernel.org/lkml/bb46ebae-4746-90d9-ec5b-fce4c9328c86@gmail.com/
> Link:
> https://lore.kernel.org/lkml/0e3f7653-c59d-9341-9db2-c88f5b988c68@gmail.com/
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
> Changelog:
> v1->v2: added selfests
> v2->v3: added comments, don't assume writable /lib/firmware
> ---
>  drivers/base/firmware_loader/main.c           |   6 +-
>  fs/exec.c                                     |  26 +++
>  include/linux/fs.h                            |   2 +
>  tools/testing/selftests/firmware/Makefile     |   9 +-
>  .../testing/selftests/firmware/fw_namespace.c | 151 ++++++++++++++++++
>  .../selftests/firmware/fw_run_tests.sh        |   4 +
>  6 files changed, 190 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/firmware/fw_namespace.c
> 
> diff --git a/drivers/base/firmware_loader/main.c
> b/drivers/base/firmware_loader/main.c
> index 249add8c5e05..01f5315fae53 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -493,8 +493,10 @@ fw_get_filesystem_firmware(struct device *device,
> struct fw_priv *fw_priv,
>                 }
> 
>                 fw_priv->size = 0;
> -               rc = kernel_read_file_from_path(path, &buffer, &size,
> -                                               msize, id);

Something happened to your patch :(

It is line-wrapped and all tabs are turned into spaces, making it
impossible to apply.  You can't use the web interface of gmail for
patches, as it corrupts them as is shown here.

Can you just use 'git send-email' instead?

thanks,

greg k-h
