Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C77C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5082084C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XydPioSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIBIF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIBIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:05:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B697C061244;
        Wed,  2 Sep 2020 01:05:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so2396452pfp.11;
        Wed, 02 Sep 2020 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Axgt7L1myipOLCzLrWVCtoFcIo5aBLztXbIMAUZRwvQ=;
        b=XydPioSIDfTER4dOGJNQCWJaiCavOsiCD6E4pAtOdDSs/Iv88xVB0NQhw1V9FKpXSu
         WExncXEqF6ywu1Wb4yWeU4vXHbb4Bjr2sHUirnuaVDNoGgw+qT5hmOZeVqNUc/yTcJBg
         WZlXNoXG9dyVD4beFdfcu4OJzXySOjUgj7bmckL9IqG8JZuk0e2Qym4xrAhXTY5Piqhi
         1v2EmKgualoLofrJEhkm7e5zUf42aMb69DaAkZb1F37dK0MD61iW0jPsvJRQbZ8ZkIWn
         wlO5i7CGHSzWzhqQ8/k+34WBZsG6+QD6SstLatsMMzFhwc17rqDBY+VkBiE1mPTAA4/y
         x8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Axgt7L1myipOLCzLrWVCtoFcIo5aBLztXbIMAUZRwvQ=;
        b=dM0tFDztFj87bu4+aOXQbvFNFzb0YENzzRZTbSsM/wOe+PLgHnyD62xXK4O7uPPeSC
         vWu1O2hCSgOYgZmEvAsVxu9IztuDfXR3LAX6nUIvg/QzDKwqHLbYaTlLTzoXgaZeLItV
         8hyYX1CXBEkfKXPZ04TZ6SnmX8KcN1Ou1hKpJ0H8igyE6FtMG7U3y+P7CeJlQzI3gUcg
         W/7stHBIY0jIyMPKudUoZ0YepeWP+SJRSMHIP7CvDc4OzzfKTL4Vgp9je5DYxQkbBIyJ
         wEemMcaW7SV7RBoWepObiE0RtI1OyzE9hKFxkbofV0FheKAdDgxIB+50gAVpjL63y8Z0
         cJYw==
X-Gm-Message-State: AOAM530PuLXVJ0MJ+hiDpMSR3+NQw7DNUc+9o2m1+BXxveTfwUkJEYiF
        Y2pCBVU9k4NJaIVtTmJmgSGuzNWgpuE6vQNfH3Y=
X-Google-Smtp-Source: ABdhPJxCp5XNghC0w3tce1tDESja+OK/Jfg4IVUHnu4xLa7D4QV2PN9d/RvJ+PdkDvuYgsWcrsrpTEoZn3CHsvRIkBk=
X-Received: by 2002:a63:c543:: with SMTP id g3mr1066714pgd.203.1599033914625;
 Wed, 02 Sep 2020 01:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200730143122.10237-1-divya_bharathi@dell.com> <9b0e8473-1582-eb02-70f4-0f25d09c720c@redhat.com>
In-Reply-To: <9b0e8473-1582-eb02-70f4-0f25d09c720c@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 11:04:57 +0300
Message-ID: <CAHp75Vfxgf4ttL931M08WqiWVELtZQotHvikDbmrTGkOyd=ZtQ@mail.gmail.com>
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Divya Bharathi <divya27392@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 5:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/30/20 4:31 PM, Divya Bharathi wrote:

...

> > +bool get_pending_changes(void)
> > +{
> > +     struct wmi_interface_priv *priv;
> > +
> > +     priv = get_first_interface_priv();
> > +     if (priv)
> > +             return priv->pending_changes;

> > +     return 0;

0 is not boolean.

> > +}

...

> > +int set_attribute(const char *a_name, const char *a_value)
> > +{

> > +     int ret = -1;
> > +     int i;
> > +     u8 *name_len, *value_len;
> > +     char *current_password, *attribute_name, *attribute_value;
> > +     size_t security_area_size;
> > +     size_t string_area_size;
> > +     size_t buffer_size;
> > +     struct wmi_interface_priv *priv;
> > +     char *buffer;

Consider to use reversed xmas tree order. And what -1 means?

> > +     /* look up if user set a password for the requests */
> > +     current_password = get_current_password("Admin");
> > +     if (!current_password)
> > +             return -ENODEV;
>
> Can we instead of passing "Admin" and "System" to this function
> just have 2 separate get_current_admin_password and get_current_system_password
> helpers and then drop the error handling ?
>
> > +
> > +     /* password is set */
> > +     if (strlen(current_password) > 0)
> > +             security_area_size = (sizeof(u32) * 2) + strlen(current_password) +
> > +                                     strlen(current_password) % 2;
> > +     /* password not set */
> > +     else
> > +             security_area_size = sizeof(u32) * 2;
>
> Since you are using more then 1 line here please use {} around the state-ments,
> also please put the /* password not set */ after the else:
>
>                 ...
>         } else { /* password not set */
>                 ...
>
> > +     string_area_size = (strlen(a_name) + strlen(a_value))*2;
> > +     buffer_size = security_area_size + string_area_size + sizeof(u16) * 2;
> > +
> > +     buffer = kzalloc(buffer_size, GFP_KERNEL);

Actually above looks like home grown kasprintf() implementation.

> > +     if (!buffer)
> > +             return -ENOMEM;
> > +
> > +     /* build security area */
> > +     if (strlen(current_password) > 0)
> > +             populate_security_buffer(buffer, current_password);

> > +     name_len = buffer + security_area_size;
> > +     attribute_name = name_len + sizeof(u16);
> > +     value_len = attribute_name + strlen(a_name)*2;
> > +     attribute_value = value_len + sizeof(u16);
> > +
> > +     /* turn into UTF16 strings, no NULL terminator */
> > +     *name_len = strlen(a_name)*2;
> > +     *value_len = strlen(a_value)*2;
> > +     for (i = 0; i < strlen(a_name); i++)
> > +             attribute_name[i*2] = a_name[i];
> > +     for (i = 0; i < strlen(a_value); i++)
> > +             attribute_value[i*2] = a_value[i];
>
> This assumes the incoming string is ASCII only and won't
> work when the incoming string is UTF-8. It is probably
> better to use the utf8s_to_utf16s() helper from the nls
> code, this will mean adding a dependency on CONFIG_NLS
> which typically is used for filesystem code, but I think
> that that will be fine.

+1. Also my thought.

> > +     mutex_lock(&call_mutex);
> > +     priv = get_first_interface_priv();
> > +     if (!priv) {
> > +             ret = -ENODEV;

> > +             pr_err(DRIVER_NAME ": no WMI backend bound");

If you wish, define pr_fmt() rather than putting this DRIVER_NAME to
each of the pr_*() call.

> > +             goto out_set_attribute;
> > +     }
> > +
> > +     ret = call_biosattributes_interface(priv->wdev, buffer, buffer_size,
> > +                                             SETATTRIBUTE_METHOD_ID);
> > +     if (ret == -EOPNOTSUPP)
> > +             dev_err(&priv->wdev->dev, "admin password must be configured");
> > +     else if (ret == -EACCES)
> > +             dev_err(&priv->wdev->dev, "invalid password");
> > +
> > +     priv->pending_changes = 1;
> > +out_set_attribute:
> > +     kfree(buffer);
> > +     mutex_unlock(&call_mutex);
> > +
> > +     return ret;
> > +}

Above comments, as a rule of thumb, should be considered against
entire code (where appropriate and applicable).

-- 
With Best Regards,
Andy Shevchenko
