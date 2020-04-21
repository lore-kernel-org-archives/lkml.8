Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D0C55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3078220724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hrKLA4Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDUVsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:48:40 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:45958
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDUVsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587505717; bh=wuTsmwDyCQPpSXymTxszNIYJyTBCNh7rsldOYFR8lOs=; h=To:Cc:From:Subject:Date:References:From:Subject; b=hrKLA4OynHJLg2bS/NDUolwl3frKrHmgSg92iV2bCjnEGWt/EUVj+ZC/GGAekS5MVNXsrvtYxlKV2wZaMY7A4u5W5fewMDf62IHcjd94L1bf4s3cNU5CjGbWWLCy/JOo5+tw1ZVVa48+zDF6OE7GRuVM1+AloYfGjuf0pu0NblRB39nyQx5DyinUJ2WOWKut10wBrilmAajpZ0OoSA4L1v7QFu+6UcUYGYQESZMKUZReWSBoQdo0ADcCOWZFrj4CEXdK2Y6c69Wtji9MfIx/FVmzFgTlIssi6/juyc3SWs/zCXaCCNWBfdUkduzmp8h4/plORhPS0J94WzCyaPg3bw==
X-YMail-OSG: yDF_AFYVM1lfg.XCSMHFzDa3vgoUryKhAPkio4J8SmV3siHXvCSM45LbDRuc8ax
 eKhJli4N0gJ8QI78kawH61P3_CEjvv4wcl7V7o7EFQlNFomcqMiVqUXOAOWlVaLmBaWlElEb_SPv
 j3dCgfMg9p2fwWuW_vGZuEt22waaMN7v_yQkeMmUK9mAUx0dSd6S4AVfC4iLu8.tzi4b0exsKLNt
 fLJ3RPwqt4zDcOHCERFp66PF.BUYRCsulVpM6x9W.F56xS7YuRMUtVjizla6d0BpNHdHd0k.07xW
 r4f6j3MN5RpPKpHkoWPPDk.HJ.7AYHE9EYMdh9WLsnPcW_K.JKISwMBp.NShjWuboGPkfLmyAcz1
 WtqGDkLez6W0CpXCSA2XgYZj5kiZG6zdjMuBMiN66KuOozvnoBv10usiWsE3eECQgtsukRTvbjzb
 q7FbFQ6j1jxMtFh_oNzIgkrLalBgAEJ6hOi2p3K2aYF0gOqVWhGQsG.081XJlqs18MsE_F.JJv0Z
 HqSSCumAZ93HohJRKynj2PVweTL63YCFuK2V.1dLG4Dwyf_xYsL2Wrj4AG_Q9ZIvOT0TmdSj69Cy
 0hz7Qb7WEbNeSjR2qJ52MEHv8av9HLG6y13vYHWs9.M1uCFEe8gxK16CM_rd9bibIRWE2nAa079Y
 7qkNi9TfveQWcHxiG17LHBdp5XuGzlohYoZ2VQp9DUEVaT3BheP13kplO1MEZXrvo37Gbm2rzieu
 1Ecmh.jmdmHyjTyumIA_oypNmobq2hb94S29TahcQ3X07MEc7.4jGK4Ye9GsT05z2yuIJf0CYBy5
 EXi980kBcoUnPo8xleUZZsRODECokw6SO4RL_UCC8s4UU98ImyQJpNYi7vrqvZbbBBPpeMIsMLmp
 QRM5EL7JCbVx9EJI7dj0ycqM637mxNKa6NgBi7zCrTx7I4BddPmMmTU9ZMZdb.Q4H0TCiuHtm.ut
 KRO4jW_m7r.qUEL2Z0dnlDvs9h854BZ1bCvAmwxN8tFz.fnrbMSbFdrcZCUxnRRS8sYk8DkttJmk
 ceMrFlFMXCRukr8wgwG6sp1DJN5BY7kee7Rlh5lBvHnzIrCOklg8MbzdpDgtcAOP1n.V_UCDJErR
 PLyM5j1yMbWYpwpMVrGQevC60zLkYoeV4q7siMWP1_WYQ44jJr8f4n0qFKtvHVHXCFeUnx.7ohWv
 xbQbsFgQKToaQvMwizSt72A8G3jErld7BYbQN1irefMVqEk5zqSDsfU3SspBSoQRJKX7MA7x0N_C
 33ar9TEuK0pml_p4G35J1QqaD6ydY83mav.ENAt.qLbASM.i2Bmbyujt1xHsB9o4euia8e69sNqS
 0SwyDysnG5FSSfRdplf_OIQkilrLFWcY4FE23AoN0NsJIO_z5Xr3EJc25kLCsnCVw2FxQnehNMC4
 y7eXkbPbfGdiqZ6ybK273LxP9.xZzLlbpYb7FUg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Apr 2020 21:48:37 +0000
Received: by smtp415.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 38702d2db9a74e61f245b52e4a7fe801;
          Tue, 21 Apr 2020 21:48:35 +0000 (UTC)
To:     Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] Documentation: LSM: Correct the basic LSM description
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com>
Date:   Tue, 21 Apr 2020 14:48:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
References: <4c053d72-2d58-612f-6d6b-f04226d0181e.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.15739 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first pass at updating the basic documentation on
Linux Security Modules (LSM), which is frighteningly out of date.
Remove untrue statements about the LSM framework. Replace them
with true statements where it is convenient to do so. This is
the beginnig of a larger effort to bring the LSM documentation
up to date.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/security/lsm.rst | 202 ++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 136 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index ad4dfd020e0d..91881b6fe73d 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -35,47 +35,50 @@ desired model of security. Linus also suggested the possibility of
 migrating the Linux capabilities code into such a module.
 
 The Linux Security Modules (LSM) project was started by WireX to develop
-such a framework. LSM is a joint development effort by several security
+such a framework. LSM was a joint development effort by several security
 projects, including Immunix, SELinux, SGI and Janus, and several
 individuals, including Greg Kroah-Hartman and James Morris, to develop a
-Linux kernel patch that implements this framework. The patch is
-currently tracking the 2.4 series and is targeted for integration into
-the 2.5 development series. This technical report provides an overview
-of the framework and the example capabilities security module provided
-by the LSM kernel patch.
+Linux kernel patch that implements this framework. The work was
+incorporated in the mainstream in December of 2003. This technical
+report provides an overview of the framework and the capabilities
+security module.
 
 LSM Framework
 =============
 
-The LSM kernel patch provides a general kernel framework to support
+The LSM framework provides a general kernel framework to support
 security modules. In particular, the LSM framework is primarily focused
 on supporting access control modules, although future development is
-likely to address other security needs such as auditing. By itself, the
+likely to address other security needs such as sandboxing. By itself, the
 framework does not provide any additional security; it merely provides
-the infrastructure to support security modules. The LSM kernel patch
-also moves most of the capabilities logic into an optional security
-module, with the system defaulting to the traditional superuser logic.
+the infrastructure to support security modules. The LSM framework is
+optional, requiring `CONFIG_SECURITY` to be enabled. The capabilities
+logic is implemented as a security module.
 This capabilities module is discussed further in
 `LSM Capabilities Module <#cap>`__.
 
-The LSM kernel patch adds security fields to kernel data structures and
-inserts calls to hook functions at critical points in the kernel code to
-manage the security fields and to perform access control. It also adds
-functions for registering and unregistering security modules, and adds a
-general :c:func:`security()` system call to support new system calls
-for security-aware applications.
-
-The LSM security fields are simply ``void*`` pointers. For process and
-program execution security information, security fields were added to
+The LSM framework includes security fields in kernel data structures and
+calls to hook functions at critical points in the kernel code to
+manage the security fields and to perform access control.
+It also adds functions for registering security modules.
+An interface `/sys/kernel/security/lsm` reports a comma separated list
+of security modules that are active on the system.
+
+The LSM security fields are simply ``void*`` pointers.
+The data is referred to as a blob, which may be managed by
+the framework or by the individual security modules that use it.
+Security blobs that are used by more than one security module are
+typically managed by the framework.
+For process and
+program execution security information, security fields are included in
 :c:type:`struct task_struct <task_struct>` and
-:c:type:`struct linux_binprm <linux_binprm>`. For filesystem
-security information, a security field was added to :c:type:`struct
+:c:type:`struct cred <cred>`.
+For filesystem
+security information, a security field is included in :c:type:`struct
 super_block <super_block>`. For pipe, file, and socket security
-information, security fields were added to :c:type:`struct inode
-<inode>` and :c:type:`struct file <file>`. For packet and
-network device security information, security fields were added to
-:c:type:`struct sk_buff <sk_buff>` and :c:type:`struct
-net_device <net_device>`. For System V IPC security information,
+information, security fields are included in :c:type:`struct inode
+<inode>` and :c:type:`struct file <file>`.
+For System V IPC security information,
 security fields were added to :c:type:`struct kern_ipc_perm
 <kern_ipc_perm>` and :c:type:`struct msg_msg
 <msg_msg>`; additionally, the definitions for :c:type:`struct
@@ -84,118 +87,45 @@ were moved to header files (``include/linux/msg.h`` and
 ``include/linux/shm.h`` as appropriate) to allow the security modules to
 use these definitions.
 
-Each LSM hook is a function pointer in a global table, security_ops.
-This table is a :c:type:`struct security_operations
-<security_operations>` structure as defined by
-``include/linux/security.h``. Detailed documentation for each hook is
-included in this header file. At present, this structure consists of a
-collection of substructures that group related hooks based on the kernel
-object (e.g. task, inode, file, sk_buff, etc) as well as some top-level
-hook function pointers for system operations. This structure is likely
-to be flattened in the future for performance. The placement of the hook
-calls in the kernel code is described by the "called:" lines in the
-per-hook documentation in the header file. The hook calls can also be
-easily found in the kernel code by looking for the string
-"security_ops->".
-
-Linus mentioned per-process security hooks in his original remarks as a
-possible alternative to global security hooks. However, if LSM were to
-start from the perspective of per-process hooks, then the base framework
-would have to deal with how to handle operations that involve multiple
-processes (e.g. kill), since each process might have its own hook for
-controlling the operation. This would require a general mechanism for
-composing hooks in the base framework. Additionally, LSM would still
-need global hooks for operations that have no process context (e.g.
-network input operations). Consequently, LSM provides global security
-hooks, but a security module is free to implement per-process hooks
-(where that makes sense) by storing a security_ops table in each
-process' security field and then invoking these per-process hooks from
-the global hooks. The problem of composition is thus deferred to the
-module.
-
-The global security_ops table is initialized to a set of hook functions
-provided by a dummy security module that provides traditional superuser
-logic. A :c:func:`register_security()` function (in
-``security/security.c``) is provided to allow a security module to set
-security_ops to refer to its own hook functions, and an
-:c:func:`unregister_security()` function is provided to revert
-security_ops to the dummy module hooks. This mechanism is used to set
-the primary security module, which is responsible for making the final
-decision for each hook.
-
-LSM also provides a simple mechanism for stacking additional security
-modules with the primary security module. It defines
-:c:func:`register_security()` and
-:c:func:`unregister_security()` hooks in the :c:type:`struct
-security_operations <security_operations>` structure and
-provides :c:func:`mod_reg_security()` and
-:c:func:`mod_unreg_security()` functions that invoke these hooks
-after performing some sanity checking. A security module can call these
-functions in order to stack with other modules. However, the actual
-details of how this stacking is handled are deferred to the module,
-which can implement these hooks in any way it wishes (including always
-returning an error if it does not wish to support stacking). In this
-manner, LSM again defers the problem of composition to the module.
-
-Although the LSM hooks are organized into substructures based on kernel
-object, all of the hooks can be viewed as falling into two major
+For packet and
+network device security information, security fields were added to
+:c:type:`struct sk_buff <sk_buff>` and
+:c:type:`struct scm_cookie <scm_cookie>`.
+Unlike the other security module data, the data used here is a
+32-bit integer. The security modules are required to map or otherwise
+associate these values with real security attributes.
+
+LSM hooks are maintained in lists. A list is maintained for each
+hook, and the hooks are called in the order specified by CONFIG_LSM.
+Detailed documentation for each hook is
+included in the `include/linux/lsm_hooks.h` header file.
+
+The LSM framework provides for a close approximation of
+general security module stacking. It defines
+security_add_hooks() to which each security module passes a
+:c:type:`struct security_hooks_list <security_hooks_list>`,
+which are added to the lists.
+The LSM framework does not provide a mechanism for removing hooks that
+have been registered. The SELinux security module has implemented
+a way to remove itself, however the feature has been deprecated.
+
+The hooks can be viewed as falling into two major
 categories: hooks that are used to manage the security fields and hooks
 that are used to perform access control. Examples of the first category
-of hooks include the :c:func:`alloc_security()` and
-:c:func:`free_security()` hooks defined for each kernel data
-structure that has a security field. These hooks are used to allocate
-and free security structures for kernel objects. The first category of
-hooks also includes hooks that set information in the security field
-after allocation, such as the :c:func:`post_lookup()` hook in
-:c:type:`struct inode_security_ops <inode_security_ops>`.
-This hook is used to set security information for inodes after
-successful lookup operations. An example of the second category of hooks
-is the :c:func:`permission()` hook in :c:type:`struct
-inode_security_ops <inode_security_ops>`. This hook checks
-permission when accessing an inode.
+of hooks include the security_inode_alloc() and security_inode_free()
+These hooks are used to allocate
+and free security structures for inode objects.
+An example of the second category of hooks
+is the security_inode_permission() hook.
+This hook checks permission when accessing an inode.
 
 LSM Capabilities Module
 =======================
 
-The LSM kernel patch moves most of the existing POSIX.1e capabilities
-logic into an optional security module stored in the file
-``security/capability.c``. This change allows users who do not want to
-use capabilities to omit this code entirely from their kernel, instead
-using the dummy module for traditional superuser logic or any other
-module that they desire. This change also allows the developers of the
-capabilities logic to maintain and enhance their code more freely,
-without needing to integrate patches back into the base kernel.
-
-In addition to moving the capabilities logic, the LSM kernel patch could
-move the capability-related fields from the kernel data structures into
-the new security fields managed by the security modules. However, at
-present, the LSM kernel patch leaves the capability fields in the kernel
-data structures. In his original remarks, Linus suggested that this
-might be preferable so that other security modules can be easily stacked
-with the capabilities module without needing to chain multiple security
-structures on the security field. It also avoids imposing extra overhead
-on the capabilities module to manage the security fields. However, the
-LSM framework could certainly support such a move if it is determined to
-be desirable, with only a few additional changes described below.
-
-At present, the capabilities logic for computing process capabilities on
-:c:func:`execve()` and :c:func:`set\*uid()`, checking
-capabilities for a particular process, saving and checking capabilities
-for netlink messages, and handling the :c:func:`capget()` and
-:c:func:`capset()` system calls have been moved into the
-capabilities module. There are still a few locations in the base kernel
-where capability-related fields are directly examined or modified, but
-the current version of the LSM patch does allow a security module to
-completely replace the assignment and testing of capabilities. These few
-locations would need to be changed if the capability-related fields were
-moved into the security field. The following is a list of known
-locations that still perform such direct examination or modification of
-capability-related fields:
-
--  ``fs/open.c``::c:func:`sys_access()`
-
--  ``fs/lockd/host.c``::c:func:`nlm_bind_host()`
-
--  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
-
--  ``fs/proc/array.c``::c:func:`task_cap()`
+The POSIX.1e capabilities logic is maintained as a security module
+stored in the file ``security/commoncap.c``. The capabilities
+module uses the order field of the :c:type:`lsm_info` description
+to identify it as the first security module to be registered.
+The capabilities security module does not use the general security
+blobs, unlike other modules. The reasons are historical and are
+based on overhead, complexity and performance concerns.

