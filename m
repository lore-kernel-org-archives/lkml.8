Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D5EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE6B20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589383240;
	bh=PG5I2bzme/83YuF1AHG3IlJmjtIvjHYIaV19Gaual/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u6TH6f5hOrsDAuB1rPgaA53pNPBE6SrYGQOOms5aLwKeOmnRAvWOQuWOFY1fauBdM
	 ujDyS3h6Edr0ovRgI5idKI3TckpDe26l4jOJdleP8oxahV9IQkTBBEC/qy1syOe1D8
	 lRpsAj1ZFT1k/xwizJsD2R5X8y8I/8Rz97oLN/XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgEMPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:20:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44092 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:20:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id j4so13679288otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klA7kjCRgTh7w4ABQm1XG/GGzZPWDtCKKvZ6hhZvn0M=;
        b=YK0ioO+YfCbNiaGbOoSJRicx6qImHVCju1HKhrbmZ+nAvS238PNTwdF2e8T7HZbTWW
         7ThBzh6Ypt0tU6ddGckPvCTonNrN4FoCIqedhj+9V+5vCMXnmB/0xEG+6on6grUvLVA1
         VekEw4jRwmH9LhGweKlmEf2kYFzp95crlrIx1XbtVWFlBHMsk8HcWDE21dgo4LZLahYD
         kvPW0O4nqLEbuZFOOVSO1tuvvUwdwKhfemGivyz+YRyMLqJL0y1y8S1LFYsNgF6Bdk06
         6RRGLEOvoLZkcOiVM5t6/9PhBlHaSWyyr5BlmaT7vqUb7dgX6ZItMD0U6+qH6b2J3dUc
         0gEg==
X-Gm-Message-State: AGi0PuboOSvRofnPZ4xXwz6ZOHnFXuYuqxcfjfU9bpEGD2IXkchCO0vu
        mE7iQJA+jvj9Bnlwd+eIYaaXVWSLPJxqDk3aTBY=
X-Google-Smtp-Source: APiQypI8Aw7GHNMbnvdlatUvOMGOBY4JkzTqMYMucj6SftC0csp2x2kbkUIA3PLWBYRoCQ3rzTxqhilz4ZlCHrhcefQ=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr20242588oto.118.1589383237714;
 Wed, 13 May 2020 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 May 2020 17:20:26 +0200
Message-ID: <CAJZ5v0gJ0jCEVX=3zJfkRJdeoAot0nKFUOAoMSi9e_hdi8peqw@mail.gmail.com>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 5:18 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
>
> To fix that, adding function __kboject_del() that does
> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  lib/kobject.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 65fa7bf70c57..32432036bef8 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -599,14 +599,7 @@ int kobject_move(struct kobject *kobj, struct kobject *new_parent)
>  }
>  EXPORT_SYMBOL_GPL(kobject_move);
>
> -/**
> - * kobject_del() - Unlink kobject from hierarchy.
> - * @kobj: object.
> - *
> - * This is the function that should be called to delete an object
> - * successfully added via kobject_add().
> - */
> -void kobject_del(struct kobject *kobj)
> +static void __kobject_del(struct kobject *kobj)
>  {
>         struct kernfs_node *sd;
>         const struct kobj_type *ktype;
> @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
>
>         kobj->state_in_sysfs = 0;
>         kobj_kset_leave(kobj);
> -       kobject_put(kobj->parent);
>         kobj->parent = NULL;
>  }
> +
> +/**
> + * kobject_del() - Unlink kobject from hierarchy.
> + * @kobj: object.
> + *
> + * This is the function that should be called to delete an object
> + * successfully added via kobject_add().
> + */
> +void kobject_del(struct kobject *kobj)
> +{
> +       struct kobject *parent = kobj->parent;
> +
> +       __kobject_del(kobj);
> +       kobject_put(parent);
> +}
>  EXPORT_SYMBOL(kobject_del);
>
>  /**
> @@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>   */
>  static void kobject_cleanup(struct kobject *kobj)
>  {
> +       struct kobject *parent = kobj->parent;
>         struct kobj_type *t = get_ktype(kobj);
>         const char *name = kobj->name;
>
> @@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
>         if (kobj->state_in_sysfs) {
>                 pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
>                          kobject_name(kobj), kobj);
> -               kobject_del(kobj);
> +               __kobject_del(kobj);
>         }
>
>         if (t && t->release) {
> @@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
>                 pr_debug("kobject: '%s': free name\n", name);
>                 kfree_const(name);
>         }
> +
> +       kobject_put(parent);
>  }
>
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> --
> 2.26.2
>
